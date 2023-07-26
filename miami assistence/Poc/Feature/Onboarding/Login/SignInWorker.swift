//
//  SignInWorker.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/07/23.
//

import CryptoKit

import SwiftUI
import Observation
import AuthenticationServices
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

@Observable
class SignInWorker {
    var nonce = ""
    
    func signInwithGoogle() {
        DispatchQueue.main.async {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                fatalError("No client ID found in Firebase configuration")
            }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
            
            Task {
                do {
                    let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
                    
                    let user = userAuthentication.user
                    guard let idToken = user.idToken else { return }
                    let accessToken = user.accessToken
                    
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                    
                    let result = try await Auth.auth().signIn(with: credential)
                    let firebaseUser = result.user
                    print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func signInWithAppleRequest(_ request: ASAuthorizationOpenIDRequest) {
        nonce = randomNonceString()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func signInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let user):
            guard let credentials = user.credential as? ASAuthorizationAppleIDCredential else { return }
            guard let token = credentials.identityToken else { return }
            guard let tokenString = String(data: token, encoding: .utf8) else { return }
            let provider = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            
            Task {
                do {
                    try await Auth.auth().signIn(with: provider)
                    DispatchQueue.main.async {
                        print("Logged")
                    }
                } catch {
                    print("Wrong error")
                }
            }
            break
        case .failure(let error):
            dump(error, name: "error")
            break
        }
    }
}

private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError(
            "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
    }
    
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    
    let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
    }
    
    return String(nonce)
}

private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}
