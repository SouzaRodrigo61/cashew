//
//  HomeView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/06/23.
//

import SwiftUI

struct ProfileView: View {
    
    let safeArea: EdgeInsets
    let size: CGSize
    

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            StickyHeader()
            
            VStack(alignment: .leading) {
                CompanyGroup()
                
                SizedBox(height: 24)
                
                CustomizeGroup()
                
                SizedBox(height: 24)
                
                LoginGroup()
                
                SizedBox(height: 24)
                
                SupportGroup()
                
                SizedBox(height: 24)
                
                LogoutGroup()
            }
            .cardModifier(padding: 16.0, width: size.width)
            .shadow(color: .miamiBlack.opacity(0.2), radius: 20, x: 0, y: 0)
            
            SizedBox(height: (size.height * 0.05 ) + safeArea.bottom + 80)
        }
        .coordinateSpace(name: "SCROLL")
        .background(.miamiWhite)
    }
    
    
    @ViewBuilder
    private func StickyHeader() -> some View {
        let height = size.height * 0.7
        let opacityByHeight = height - safeArea.top
        
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            VStack(spacing: 0) {
                SizedBox(height: safeArea.top)
                
                Group {
                    Spacer()
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.miamiGray, .miamiDarkGraySecond)
                        .padding(36.0)
                        .background {
                            Circle()
                                .foregroundStyle(.miamiLightGray)
                        }
                        .frame(width: 120, height: 120)
                    
                    SizedBox(height: 12)
                    
                    Text("user.name".localized(args: "Rodrigo Santos"))
                        .font(.title3)
                        .foregroundStyle(.miamiDarkGraySecond)
                    
                    Text("user.finder".localized(args: "@rodrigo"))
                        .font(.callout)
                        .foregroundStyle(.miamiDarkGrayOne)
                    
                    SizedBox(height: 24)
                    
                    Text("user.profile".localized(args: "Dev iOS"))
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.miamiWhite)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .foregroundStyle(.miamiDarkGraySecond)
                        }
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "gear.badge.questionmark")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.thin)
                        .foregroundStyle(.miamiDarkGraySecond)
                        .frame(width: 32, height: 32)
                        .padding([.leading, .vertical], 16)
                    
                    VStack(alignment: .leading) {
                        Text("profile.reminder.title")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.miamiDarkGraySecond)
                            .padding([.trailing, .top], 16)
                        Text("profile.reminder.text".localized(args: "Miami"))
                            .font(.caption2)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.miamiDarkGraySecond)
                            .padding([.trailing, .bottom], 16)
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundStyle(.miamiLightPurple)
                }
                .padding(.horizontal, 16)
                
                SizedBox(height: 16)
            }
            .cardModifier(padding: 0, width: size.width, alignment: .bottom, corners: [.bottomLeft, .bottomRight])
            .frame(height: size.height + ( minY > 0 ? minY : 0))
            .clipped()
            .offset(y: -minY)
            .opacity(minY >= -opacityByHeight ? 1 : 0)
            .animation(.easeInOut(duration: 0.25), value: minY >= -opacityByHeight)
            
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    private func CompanyGroup() -> some View {
        Group {
            Text("profile.company".localized(args: "Miami Clinic"))
                .font(.title3)
                .foregroundStyle(.miamiBlack)
            
            SizedBox(height: 24)
            
            Group {
                ActionsButton(with: "swatchpalette", title: "profile.company.dashboard") {
                    dump("Testing", name: "profile.company.dashboard")
                }
                
                Text("profile.company.dashboard.describle")
                    .font(.footnote)
                    .foregroundStyle(.miamiGray)
                    .padding(.leading, 8)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(.miamiLightGray)
            }
            
            Group {
                ActionsButton(with: "swatchpalette", title: "profile.company.link") {
                    dump("Testing", name: "profile.company.link")
                }
                
                Text("profile.company.link.describle")
                    .font(.footnote)
                    .foregroundStyle(.miamiGray)
                    .padding(.leading, 8)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(.miamiLightGray)
            }
                
            Group {
                ActionsButton(with: "swatchpalette", title: "profile.company.schedule") {
                    dump("Testing", name: "profile.company.schedule")
                }
                
                Text("profile.company.schedule.describle")
                    .font(.footnote)
                    .foregroundStyle(.miamiGray)
                    .padding(.leading, 8)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(.miamiLightGray)
            }
            
            Group {
                ActionsButton(with: "swatchpalette", title: "profile.company.invoicing") {
                    dump("Testing", name: "profile.company.invoicing")
                }
                
                Text("profile.company.invoicing.describle".localized(args: "Miami Clinic"))
                    .font(.footnote)
                    .foregroundStyle(.miamiGray)
                    .padding(.leading, 8)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(.miamiLightGray)
            }
            
            ActionsButton(with: "swatchpalette", title: "profile.company.hour") {
                dump("Testing", name: "profile.company.hour")
            }
        }
    }
    
    @ViewBuilder
    private func CustomizeGroup() -> some View {
        Group {
            Text("profile.custom")
                .font(.title3)
                .foregroundStyle(.miamiBlack)
            
            SizedBox(height: 24)
            
            ActionsButton(with: "swatchpalette", title: "profile.custom.color") {
                dump("Testing", name: "profile.custom.color")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
                                
            ActionsButton(with: "chart.line.uptrend.xyaxis", title: "profile.custom.charts") {
                dump("Testing", name: "profile.custom.charts")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
                                
            ActionsButton(with: "hammer", title: "work.progress") {
                dump("Testing", name: "work.progress")
            }
        }
    }
    
    @ViewBuilder
    private func LoginGroup() -> some View {
        Group {
            Text("profile.settings.login")
                .font(.title3)
                .foregroundStyle(.miamiBlack)
            
            SizedBox(height: 24)
            
            ActionsButton(with: "shield", title: "profile.settings.login") {
                dump("Testing", name: "profile.settings.login")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
            
            
            ActionsButton(with: "creditcard", title: "profile.settings.payment") {
                dump("Testing", name: "profile.settings.payment")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
            
            
            ActionsButton(with: "bell", title: "profile.settings.notification") {
                dump("Testing", name: "profile.settings.notification")
            }
        }
    }
    
    @ViewBuilder
    private func SupportGroup() -> some View {
        Group {
            Text("profile.supports")
                .font(.title3)
                .foregroundStyle(.miamiBlack)
            
            SizedBox(height: 24)
            
            ActionsButton(with: "questionmark.circle", title: "profile.supports.howApplicationWorks") {
                dump("Testing", name: "profile.supports.howApplicationWorks")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
            
            ActionsButton(with: "ellipsis.message", title: "profile.supports.faq") {
                dump("Testing", name: "profile.supports.faq")
            }
            
            Divider()
                .frame(minHeight: 1)
                .overlay(.miamiLightGray)
            
            ActionsButton(with: "square.and.pencil", title: "profile.support.feedback") {
                dump("Testing", name: "profile.support.feedback")
            }
        }
    }
    
    @ViewBuilder
    private func LogoutGroup() -> some View {
        Group {
            Text("profile.logout.text")
                .font(.footnote)
                .foregroundStyle(.miamiGray)
            
            SizedBox(height: 12)
            
            Logout {
                dump("Logou", name: "profile.logout")
            }
            
            SizedBox(height: 12)
            
            HStack() {
                Spacer()
                Text("profile.version".localized(args: "1.0.0"))
                    .font(.caption)
                    .foregroundStyle(.miamiDarkGrayOne)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func ActionsButton(with systemName: String, title: String, with action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            HStack {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.miamiDarkGraySecond)
                    .padding(13)
                    .background {
                        Circle()
                            .foregroundStyle(.miamiLightGray)
                    }
                    .frame(width: 44, height: 44)
                
                Text(title.localized)
                    .font(.callout)
                    .foregroundStyle(.miamiDarkGraySecond)
                
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.miamiGray)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    @ViewBuilder
    private func Logout(with action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.miamiDarkGraySecond)
                	
                Text("profile.logout")
                    .foregroundStyle(.miamiDarkGraySecond)
                Spacer()
            }
            .padding()
            .background(.miamiLightGray)
            .clipShape(.rect(cornerRadius: 12, style: .continuous))
        }
    }
}


