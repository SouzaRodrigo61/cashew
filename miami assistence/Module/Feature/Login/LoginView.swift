//
//  ContentView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/06/23.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    let worker: SignInWorker
    
    init(worker: SignInWorker = SignInWorker()) {
        self.worker = worker
    }
    
    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 60
    }

    private func nanosValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        let nanos = Calendar.current.component(.nanosecond, from: date)
        return Double(seconds * 1_000_000_000 + nanos) / 60_000_000_000
    }
    
    var body: some View {
        GeometryReader {
            VStack(alignment: .center) {
                
                TimelineView(.animation) { context in
                    let date = context.date
                    let value = context.cadence <= .live ?
                        nanosValue(for: date): secondsValue(for: date)

                    Circle()
                        .trim(from: 0, to: value)
                        .stroke()
                }
                
                Spacer()
                
                
                Button {
                    worker.signInwithGoogle()
                } label: {
                    HStack {
                        SizedBox(width: 16)
                        Image(.google)
                            .renderingMode(.original)
                            .accessibility(label: Text("Sign in with Google"))
                        
                        Text("Sign in with Google")
                            .foregroundStyle(.miamiWhite)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                }
                .padding(.vertical)
                .frame(height: 60)
                .background(.miamiBlack)
                .cornerRadius(8)
                .shadow(color: Color.init(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.06), radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                
                SizedBox(height: 12)
                
                SignInWithAppleButton(.signIn) { request in
                    worker.signInWithAppleRequest(request)
                } onCompletion: { result in
                    worker.signInWithAppleCompletion(result)
                }
                .font(.title3)
                .frame(height: 60)
                .signInWithAppleButtonStyle(.black)
                .cornerRadius(8)
                .padding(.horizontal)
            }
            .frame(width: $0.size.width)
            .background(.miamiWhite)
        }
    }
}
