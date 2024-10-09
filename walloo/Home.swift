//
//  Home.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import CoreData
import StoreKit
import UserNotifications
import Combine

struct Home: View {
    @Binding var showNotesView: Bool
    @Binding var showPasswordsView: Bool
    @Binding var showLoginsView: Bool
    @Binding var showBanksView: Bool
    @Binding var showFilesView: Bool

    @State private var showingAddScreen = false
    @State private var showingNotifications = false
    @State var goSecondOnboard = false
    @State var showNews = false
    @State var index = 0

    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var audioRecorder: AudioRecorder
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Card.entity(), sortDescriptors: [
                    NSSortDescriptor(keyPath: \Card.cardNumber, ascending: true),])
    var cards: FetchedResults<Card>
    @FetchRequest(entity: CardID.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \CardID.identityName, ascending: true)])
    var cardsID: FetchedResults<CardID>
    @FetchRequest(entity: Insurance.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Insurance.insuranceGivenNames, ascending: true)])
    var insurance: FetchedResults<Insurance>
    @FetchRequest(entity: Drive.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Drive.driveFullName, ascending: true)])
    var driveCard: FetchedResults<Drive>
    @FetchRequest(entity: Passport.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \Passport.passportName, ascending: true)])
    var passport: FetchedResults<Passport>
    
    var body: some View{
        NavigationView{
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    ZStack{
                        subHeader(audioRecorder: self.audioRecorder, showNotesView: $showNotesView, showPasswordsView: $showPasswordsView, showLoginsView: $showLoginsView, showBanksView: $showBanksView, showFilesView: $showFilesView).environment(\.managedObjectContext, self.moc)
                        
                    }
                    .padding(.top, 20)
                    VStack(spacing: 0){
                        
                        // CREDIT CARDS
                        if cards.count + cardsID.count + insurance.count > 0 {
                            ForEach(cards, id: \.self) {card in
                                GeometryReader{ geometry in
                                    CreditCard( card: card)
                                }
                                .padding(.top, 70)
                            }
                        } else if cards.count + cardsID.count + insurance.count <= 0 {
                            VStack{
                                VStack{
                                    Text("Start adding your National ID!")
                                        .font(.headline)
                                    Image(systemName: "arrow.down")
                                        .font(.system(size: 27))
                                        .padding(.top)
                                    
                                }
                                .padding(.top,40)
                            }
                            .offset(y: 50)
                        }
                        
                        // CARDS ID
                        ForEach(cardsID, id: \.self) {cardID in
                            GeometryReader{ geometry in
                                IdentityCard( cardID: cardID).environment(\.managedObjectContext, self.moc)
                            }
                            .padding(.top, 70)
                        }
                        
                        // INSURANCE CARD
                        ForEach(insurance, id: \.self) {insurance in
                            GeometryReader{ geometry in
                                InsuranceCard(insurance: insurance).environment(\.managedObjectContext, self.moc)
                            }
                            .padding(.top, 70)
                        }
                        
                        // DRIVE LICENSE
                        ForEach(driveCard, id: \.self) {driveCard in
                            GeometryReader{ geometry in
                                DriveLicence(driveCard: driveCard).environment(\.managedObjectContext, self.moc)
                            }
                            .padding(.top, 70)
                        }
                        
                        // DRIVE LICENSE
                        ForEach(passport, id: \.self) {passport in
                            GeometryReader{ geometry in
                                PassportCard(passport: passport).environment(\.managedObjectContext, self.moc)
                            }
                            .padding(.top, 70)
                        }
                    }
                    .padding(.bottom, self.passport.count > 0 ? 400 : 200)
                    .offset(y: -70)
                    .onAppear {
                        //RATING
                        if UserDefaults.standard.bool(forKey: "rate") == false {
                            SKStoreReviewController.requestReview()
                            UserDefaults.standard.setValue(true, forKey: "rate")
                        }
                    }
                }
                .navigationBarTitle(Text("All Items"), displayMode: .inline)
            }
            .onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Notifications OK")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
