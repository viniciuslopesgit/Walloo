//
//  UserView.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import StoreKit

struct UserView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @State private var shareSheetShowing = false
    @State private var link = "https://apps.apple.com/us/app/iforget/id1525213220"
    
    @State private var showbuy = false
    
    @State var showUpgradeClose = true
    @State var goSecondOnboard = false
    @State var showNews = false
    @State var showUpgrade = false
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack{
                            VStack(spacing: 0){
                                NavigationLink(destination: SecurityView()){
                                    VStack(spacing: 0){
                                        HStack{
                                            Image(systemName: "hand.raised")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color("Color4"))
                                                .padding()
                                                .frame(width: 28, height: 28)
                                            
                                            Text("Security")
                                                .foregroundColor(Color("Color4"))
                                                .font(.system(size: 15))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                .font(.system(size: 14))
                                                .opacity(0.5)
                                        }
                                        .padding()
                                    }
                                    .frame(height: 47)
                                }
                                .frame(height: 47)
                                Divider()
                                    .padding(.leading)
                                NavigationLink(destination: SyncView()){
                                    VStack(spacing: 0) {
                                        HStack{
                                            Image(systemName: "goforward")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color("Color4"))
                                                .padding()
                                                .frame(width: 28, height: 28)
                                            
                                            Text("Sync iCloud")
                                                .foregroundColor(Color("Color4"))
                                                .font(.system(size: 15))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                .font(.system(size: 14))
                                                .opacity(0.5)
                                        }
                                        .padding()
                                    }
                                    .frame(height: 47)
                                }
                                .frame(height: 47)
                                Divider()
                                /*
                                 NavigationLink(destination: UsageView()){
                                 HStack{
                                 Image(systemName: "archivebox.fill")
                                 .font(.system(size: 14))
                                 .foregroundColor(Color.white)
                                 .padding()
                                 .background(Color.blue)
                                 .frame(width: 25, height: 25)
                                 .cornerRadius(5)
                                 
                                 Text("Storage")
                                 .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                                 .font(.system(size: 14, weight: .medium))
                                 .padding(.leading, 7)
                                 
                                 Spacer()
                                 
                                 Image(systemName: "chevron.right")
                                 .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                 .font(.system(size: 14))
                                 }
                                 .padding()
                                 }
                                 .frame(height: 47)
                                 Divider()
                                 */
                            VStack(spacing: 0){
                                Divider()
                                NavigationLink(destination: HelpAndSupportView()){
                                    VStack(spacing: 0) {
                                        HStack{
                                            Image(systemName: "questionmark")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color("Color4"))
                                                .padding()
                                                .frame(width: 28, height: 28)
                                            
                                            Text("Help and Support")
                                                .foregroundColor(Color("Color4"))
                                                .font(.system(size: 15))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                .font(.system(size: 14))
                                                .opacity(0.5)
                                        }
                                        .padding()
                                    }
                                    .frame(height: 47)
                                }
                                .frame(height: 47)
                                Divider()
                                    .padding(.leading)
                                NavigationLink(destination: About()){
                                    VStack(spacing: 0){
                                        VStack(spacing: 0) {
                                            HStack{
                                                Image(systemName: "info")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(Color("Color4"))
                                                    .padding()
                                                    .frame(width: 28, height: 28)
                                                
                                                Text("About")
                                                    .foregroundColor(Color("Color4"))
                                                    .font(.system(size: 15))
                                                
                                                Spacer(minLength: 0)
                                                
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                    .font(.system(size: 14))
                                                    .opacity(0.5)
                                            }
                                            .padding()
                                        }
                                    }
                                    .frame(height: 47)
                                }
                                .frame(height: 47)
                            }
                            .padding(.top, 47)
                            Divider()
                            
                            VStack(spacing: 0){
                                Divider()
                                VStack(spacing: 0){
                                    Button(action:{
                                        self.shareButton()
                                    }){
                                        HStack{
                                            Image(systemName: "suit.heart")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color("Color4"))
                                                .padding()
                                                .frame(width: 28, height: 28)
                                            
                                            Text("Tell a friend")
                                                .foregroundColor(Color("Color4"))
                                                .font(.system(size: 15))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                .font(.system(size: 14))
                                                .opacity(0.5)
                                        }
                                    }
                                    .padding()
                                }
                                .frame(height: 47)
                                Divider()
                                    .padding(.leading)
                                VStack(spacing: 0){
                                    Button(action:{
                                        SKStoreReviewController.requestReview()
                                    }){
                                        HStack{
                                            Image(systemName: "star")
                                                .font(.system(size: 17))
                                                .foregroundColor(Color("Color4"))
                                                .padding()
                                                .frame(width: 28, height: 28)
                                            
                                            Text("Rate us")
                                                .foregroundColor(Color("Color4"))
                                                .font(.system(size: 15))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                .font(.system(size: 14))
                                                .opacity(0.5)
                                        }
                                    }
                                    .padding()
                                }
                                .frame(height: 47)
                                Divider()
                            }
                            .padding(.top, 47)
                                
                                VStack(spacing:0 ){
                                    Divider()
                                    NavigationLink(destination: Logout()){
                                        VStack(spacing: 0){
                                            HStack{
                                                Spacer(minLength: 0)
                                                
                                                Text("Logout")
                                                    .foregroundColor(Color.red)
                                                    .font(.system(size: 15))
                                                
                                                Spacer(minLength: 0)
                                                
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                                    .font(.system(size: 14))
                                                    .opacity(0.5)
                                            }
                                            .padding()
                                        }
                                        .frame(height: 47)
                                    }
                                    .frame(height: 47)
                                    Divider()
                                }
                                .padding(.top, 47)
                            
                            VStack(alignment: .center){
                                Spacer(minLength: 0)
                                Text("© 2020 iForget. All rights reserved.")
                                    .font(.system(size: 12))
                                    .opacity(0.2)
                                Text("iForget 2.4.0")
                                    .font(.system(size: 12))
                                    .opacity(0.2)
                                Spacer(minLength: 0)
                            }
                            .padding(.top, 35)
                            
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 35)
                        .navigationBarTitle("Account", displayMode: .inline)
                            .navigationBarItems(trailing:
                                HStack{
                                    if userSettings.proBuy == false {
                                        Button(action: {
                                            self.showUpgrade.toggle()
                                        }){
                                        ZStack{
                                            Capsule()
                                                .foregroundColor(Color.white)
                                            Capsule()
                                                .stroke(Color(#colorLiteral(red: 0.02676662794, green: 0.2080936173, blue: 0.8072781736, alpha: 1)), lineWidth: 2)
                                                    Text("Upgrade")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.01933043593, green: 0.1502819237, blue: 0.5830035463, alpha: 1)))
                                                        .font(.system(size: 12, weight: .bold))
                                                        .padding(.horizontal)
                                                        .padding(.vertical, 5)
                                            }
                                        }
                                    }
                                }
                            )
                        .navigationViewStyle(StackNavigationViewStyle())
                    }
                    .sheet(isPresented: self.$showUpgrade)  {
                        VStack{
                            OnboardingOne(showUpgradeClose: $showUpgradeClose, goSecondOnboard: $goSecondOnboard, showNews: $showNews, showUpgrade: $showUpgrade)
                                .navigationBarHidden(true)
                        }
                        .onAppear{
                            self.showUpgradeClose = true
                        }
                        .onTapGesture {
                            if self.showUpgradeClose == false {
                                self.showUpgrade.toggle()
                            }
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    if self.userSettings.isAutoLock {
                        self.showbuy = false
                    }
                }
            }
        }
    }
    func shareButton() {
        self.shareSheetShowing.toggle()
        let url = URL(string: link)
        let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
