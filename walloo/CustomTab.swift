//
//  CustomTab.swift
//  iForget
//
//  Created by Vinícius Lopes on 05/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import GoogleMobileAds

struct NewCustomTab : View {
    @Binding var showNotesView: Bool
    @Binding var showPasswordsView: Bool
    @Binding var showLoginsView: Bool
    @Binding var showBanksView: Bool
    @Binding var showFilesView: Bool
    @Binding var index : Int
    @Binding var showAdd: Bool
    @Binding var isUnlocked: Bool
    @Binding var password: String
    
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var showAd = false
    @State var timeRemaining = 99999999
    @State var rewardedAd: GADRewardedAd?
    
    var body: some View {
        HStack{
            VStack(spacing: 0){
                VStack{
                    Image(systemName: self.index == 0 ? "doc.plaintext.fill" : "doc.plaintext")
                        .font(.system(size: 20))
                }
                .padding(.vertical, 10)
            }
            .background(Color("ColorNavBar"))
            .frame(width: UIScreen.main.bounds.width / 5)
            .foregroundColor(self.index == 0 ? Color.white : Color.white.opacity(0.5))
            .onTapGesture {
                self.showAd = true
                self.index = 0
                UserDefaults.standard.setValue(index, forKey: "index")
                
                self.showNotesView = false
                self.showPasswordsView = false
                self.showLoginsView = false
                self.showBanksView = false
                self.showFilesView = false
                
            }

            Spacer(minLength: 0)
            
            VStack(spacing: 0){
                VStack{
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23))
                }
                .padding(.vertical, 10)
            }
            .background(Color("ColorNavBar"))
            .frame(width: UIScreen.main.bounds.width / 5)
            .foregroundColor(self.index == 1 ? Color.white : Color.white.opacity(0.5))
            .onTapGesture {
                self.showAd = true
                self.index = 1
                UserDefaults.standard.setValue(index, forKey: "index")
            }
            VStack(spacing: 0){
                VStack{
                    Image(systemName: "plus")
                        .font(.system(size: 27))
                }
                .padding(.vertical, 10)
            }
            .frame(width: UIScreen.main.bounds.width / 5)
            .foregroundColor(Color.white.opacity(0.5))
            .onTapGesture {
                self.showAdd.toggle()
                self.showAd = true
            }

            Spacer(minLength: 0)
    
            VStack(spacing: 0){
                VStack{
                    Image(systemName: self.index == 2 ? "star.fill" : "star")
                        .font(.system(size: 20.5, weight: .medium))
                }
                .padding(.vertical, 10)
            }
            .background(Color("ColorNavBar"))
            .frame(width: UIScreen.main.bounds.width / 5)
            .foregroundColor(self.index == 2 ? Color.white : Color.white.opacity(0.5))
            .onTapGesture {
                self.showAd = true
                self.index = 2
                UserDefaults.standard.setValue(index, forKey: "index")
            }
            
            Spacer(minLength: 0)
            
            VStack(spacing: 0){
                VStack{
                    Image(systemName: self.index == 3 ? "circle.fill" : "circle")
                        .font(.system(size: 22))
                }
                .padding(.vertical, 10)
            }
            .background(Color("ColorNavBar"))
            .frame(width: UIScreen.main.bounds.width / 5)
            .foregroundColor(self.index == 3 ? Color.white : Color.white.opacity(0.5))
            .onTapGesture {
                self.showAd = false
                self.index = 3
                UserDefaults.standard.setValue(index, forKey: "index")
            }
        }
        .frame(height: 47)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 3 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color("ColorNavBar").edgesIgnoringSafeArea(.all))
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.userSettings.isAutoLock == true {
                self.isUnlocked = false
                self.password = ""
                self.showAdd = false
            }
        }
    }
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.showAd = true
    }
    /// Tells the delegate an ad request failed.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}