//
//  FavouritesView.swift
//  iForget
//
//  Created by Vinícius Lopes on 12/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct FavouritesView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack(spacing: 0){
                    FavouritesAll().environment(\.managedObjectContext, self.moc)
                }
                .navigationBarTitle("Favourites", displayMode: .inline)
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}


struct FavouritesAll : View {
   
    @ObservedObject var userSettings = UserSettings()
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Note.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Note.fav, ascending: true)],
                  predicate: NSPredicate(format: "fav = true"))
    var note: FetchedResults<Note>
    
    @FetchRequest(entity: Password.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Password.fav, ascending: true)],
                  predicate: NSPredicate(format: "fav = true"))
    var password: FetchedResults<Password>
    
    @FetchRequest(entity: Login.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Login.fav, ascending: true)],
                  predicate: NSPredicate(format: "fav = true"))
    var login: FetchedResults<Login>
    
    @FetchRequest(entity: BankAccount.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \BankAccount.fav, ascending: true)],
                  predicate: NSPredicate(format: "fav = true"))
    var bankAccount: FetchedResults<BankAccount>
    
    @State var showCopy = false
    
    @State var showModalText = false
    @State var showModalPassword = false
    @State var showModalLogin = false
    @State var showModalBank = false
    
    @State var countNotesFav: Int = 0
    @State var countPasswordsFav: Int = 0
    @State var countLoginsFav: Int = 0
    @State var countBanksFav: Int = 0
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Text("Copied ***** to clipboard")
                        .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                        .font(.system(size: 14, weight: .medium))
                        .padding()
                        .fixedSize()
                }
                .background(Color(#colorLiteral(red: 0.9142013008, green: 0.9142013008, blue: 0.9142013008, alpha: 1)))
                .opacity(1.0)
                .frame(height: 47)
                .cornerRadius(5)
            }
            .padding(.bottom)
            .zIndex(1)
            .opacity(showCopy ? 1.0 : 0.0)
            .animation(.spring())
            VStack(spacing:0){
                
                if note.count + password.count + login.count + bankAccount.count != 0 {
                    
                ScrollView(.vertical, showsIndicators: false){
                    
                    
                    
                    //NOTES
                    
                    if self.countNotesFav > 0 {
                        VStack(spacing: 0){
                            HStack{
                                Text("NOTES")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .frame(maxHeight: self.countNotesFav > 0 ? 50 : 0)
                        .padding(.top)
                        
                    }
                    VStack(spacing: 1){
                        ForEach(note, id: \.self) {note in
                            VerifyFavoriteNotes( countNotesFav: self.$countNotesFav, showModalText: self.$showModalText, note: note).environment(\.managedObjectContext, self.moc)
                                .fullScreenCover(isPresented: $showModalText){
                                    DetailNote(note: note).environment(\.managedObjectContext, self.moc)
                                }
                        }
                    }
                    
                    //PASSWORDS
                    
                    if self.countPasswordsFav > 0 {
                        VStack(spacing: 0){
                            HStack{
                                Text("PASSWORDS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                    }
                    VStack(spacing:1){
                        ForEach(password, id: \.self) {password in
                            VerifyFavoritePasswords( showCopy: self.$showCopy, countPasswordsFav: self.$countPasswordsFav, showModalPassword: self.$showModalPassword, password: password).environment(\.managedObjectContext, self.moc)
                                .fullScreenCover(isPresented: $showModalPassword){
                                    NavigationView{
                                        DetailPasswordView(password: password).environment(\.managedObjectContext, self.moc)
                                    }
                                }
                        }
                    }
                    
                    //LOGINS
                    
                    if self.countLoginsFav > 0 {
                        VStack(spacing: 0){
                            HStack{
                                Text("LOGINS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                    }
                    VStack(spacing: 1){
                        ForEach(login, id: \.self) {login in
                            VerifyFavoriteLogin( showCopy: self.$showCopy, countLoginsFav: self.$countLoginsFav, showModalLogin: self.$showModalLogin, login: login).environment(\.managedObjectContext, self.moc)
                                
                        }
                    }
                    
                    //BANK ACCOUNTS
                    
                    if self.countBanksFav > 0 {
                        VStack(spacing: 0){
                            HStack{
                                Text("BANK ACCOUNTS")
                                    .font(.system(size: 13, weight: .medium))
                                    .opacity(0.3)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                        .padding(.top)
                    }
                    VStack(spacing: 0){
                        ForEach(bankAccount, id: \.self) {bankAccount in
                            VerifyFavoriteBankAccount( showCopy: self.$showCopy, countBanksFav: self.$countBanksFav, showModalBank: self.$showModalBank, bankAccount: bankAccount).environment(\.managedObjectContext, self.moc)
                                .fullScreenCover(isPresented: self.$showModalLogin){
                                    NavigationView{
                                        DetailBankAccountView( bankAccount: bankAccount).environment(\.managedObjectContext, self.moc)
                                    }
                                }
                        }
                    }
                    
                    //
                    
                    
                    
                }
                    
                } else {
                    VStack{
                        Spacer(minLength: 0)
                        
                        Image(systemName: "star")
                            .font(.system(size: 55, weight: .light))
                            .padding()
                            .opacity(0.5)
                        
                        Text("Using files over and over?")
                            .font(.system(size: 18, weight: .medium))
                            .padding(5)
                        Text("Bookmark your files and access them quickly")
                        
                        Spacer(minLength: 0)
                    }
                    .opacity(0.35)
                }
            }
        }
    }
}

struct VerifyFavoriteNotes: View {
    
    @State var showCopy = false
    
    @Binding var countNotesFav : Int
    @Binding var showModalText : Bool
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @State private var textRemoveReminder  = ""
    @State var showOptionsReminder = false
    
    @State private var dateNotification = 0
    @State private var dateNotification1hour = Int(3600)
    @State private var dateNotificationTomorrow = Int(86400)
    @State private var dateNotificationNextWeek = Int(604800)
    
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var note: Note
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                HStack{
                    Spacer()
                    
                    Image(systemName: self.note.fav ? "star.fill" : "star")
                        .foregroundColor(Color("Color5"))
                        .padding(.trailing, 20)
                        .onTapGesture {
                            self.activeSwipeLeft = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                self.note.fav.toggle()
                                try? moc.save()
                            }
                        }
                    Image(systemName: self.note.reminder ? "clock.fill" : "clock")
                        .foregroundColor(Color("Color5"))
                        .padding(.trailing, 20)
                        .onTapGesture {
                            self.showOptionsReminder.toggle()
                        }
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            self.deleteNote()
                            self.activeSwipeLeft = false
                        }
                }
                .frame(height: 47)
                .background(Color.gray.opacity(0.1))
                
                HStack{
                    ZStack{
                        HStack{
                            Image(systemName: "doc.text")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Color4"))
                                .frame(width: 28, height: 28)
                            
                            Text(note.title ?? "")
                                .foregroundColor(Color("Color4"))
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            if self.note.reminder {
                                Image(systemName: "clock")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Color5"))
                            }
                        }
                        .padding(.horizontal)
                        swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                    }
                }
                .frame(height: 47)
                .background(Color("Color7"))
                .offset(x: self.activeSwipeLeft ? -170 : 0)
                .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                
            }
            Divider()
                .padding(.leading)
                
        }
        .frame(height: 47)
        .onTapGesture {
            if self.activeSwipeLeft != true {
                self.showModalText.toggle()
            } else {
                self.activeSwipeLeft = false
            }
        }
        .onAppear{
            self.activeAnimation = false
            self.countNotesFav += 1
        }
        .actionSheet(isPresented: self.$showOptionsReminder) {
            if self.note.reminder == false {
            return ActionSheet(title:  Text(""), buttons: [
                .default(Text("In an Hour")) {
                    
                    
                    self.activeSwipeLeft = false
                    
                    self.note.reminder = true
                    try? self.moc.save()
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3660){
                        self.note.reminder = false
                        try? self.moc.save()
                    }
                    
                    self.dateNotification = self.dateNotification1hour
                    
                    let content = UNMutableNotificationContent()
                    content.title = self.note.title ?? ""
                    content.body = self.note.note ?? ""
                    content.sound = UNNotificationSound.default
                    
                    let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
                    
                    let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
                    
                    let categories = UNNotificationCategory(identifier: "action", actions: [open,cancel], intentIdentifiers: [])
                    
                    UNUserNotificationCenter.current().setNotificationCategories([categories])
                    
                    content.categoryIdentifier = "action"
                    
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                    
                    let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
                },
                .default(Text("Tomorrow")) {
                    
                    self.activeSwipeLeft = false
                    
                    self.note.reminder = true
                    try? self.moc.save()
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 86460){
                        self.note.reminder = false
                        try? self.moc.save()
                    }
                    
                    self.dateNotification = self.dateNotificationTomorrow
                    
                    let content = UNMutableNotificationContent()
                    content.title = self.note.title ?? ""
                    content.body = self.note.note ?? ""
                    content.sound = UNNotificationSound.default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                },
                .default(Text("Next Week")) {
                    
                    self.activeSwipeLeft = false
                    
                    self.note.reminder = true
                    try? self.moc.save()
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 604860){
                        self.note.reminder = false
                        try? self.moc.save()
                    }
                    
                    self.dateNotification = self.dateNotificationNextWeek
                    
                    let content = UNMutableNotificationContent()
                    content.title = self.note.title ?? ""
                    content.body = self.note.note ?? ""
                    content.sound = UNNotificationSound.default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.dateNotification) , repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                },
                .cancel()
            ])
        }
            else {
                return ActionSheet(title:  Text(""), buttons: [
                    .destructive(Text("Remove Remider")) {
                        
                        self.activeSwipeLeft = false
                        
                        self.note.reminder = false
                        try? self.moc.save()
                        
                        self.dateNotification = self.dateNotificationNextWeek
                        
                        let content = UNMutableNotificationContent()
                        content.title = self.note.title ?? ""
                        content.body = self.note.note ?? ""
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1) , repeats: false)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    },
                    .cancel()
                ]
                )
            }
        }
        .background(Color.white.opacity(0.01))
    }
    func deleteNote(){
        moc.delete(note)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}

struct VerifyFavoritePasswords: View {
    
    @Binding var showCopy: Bool
    
    @Binding var countPasswordsFav : Int
    @Binding var showModalPassword : Bool
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showLink = false
    
    let password: Password
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if self.showLink == false {
                    ZStack{
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: self.password.fav ? "star.fill" : "star")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.password.fav.toggle()
                                        try? moc.save()
                                    }
                                }
                            
                            Image(systemName: "trash")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 30)
                                .onTapGesture {
                                    self.deletePassword()
                                    self.activeSwipeLeft = false
                                }
                        }
                        .frame(height: 47)
                        .background(Color.gray.opacity(0.1))
                        
                        HStack{
                            ZStack{
                                HStack{
                                    Image(systemName: "lock")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("Color4"))
                                        .padding()
                                        .frame(width: 28, height: 28)
                                    
                                    Text(password.passwordTitle ?? "")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 15))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                            }
                        }
                        .frame(height: 47)
                        .background(Color("Color7"))
                        .offset(x: self.activeSwipeLeft ? -130 : 0)
                        .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                        .onTapGesture {
                            if self.activeSwipeLeft != true {
                                self.activeAnimation = false
                                self.showLink.toggle()
                            } else {
                                self.activeSwipeLeft = false
                            }
                            
                        }
                        .onAppear{
                            self.countPasswordsFav += 1
                        }
                    }
                } else {
                    VStack(spacing: 0){
                            HStack{
                                Image(systemName: "lock")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 25, height: 25)
                                    .padding(.leading)
                                
                                Text(password.passwordTitle ?? "")
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 14))
                                    .opacity(0.3)
                                    .padding(.trailing)
                            }
                            .background(Color("Color7"))
                            .frame(height: 47)
                            .onTapGesture {
                                self.showModalPassword.toggle()
                            }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("PASSWORD")
                                            .font(.system(size: 10))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.password.passwordCode ?? "")")
                                                .font(.system(size: 15))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.leading)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.password.passwordCode
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(Color.white.opacity(0.01))
                }
                Divider()
                    .padding(.leading)
            }
        }
    }
    func deletePassword(){
        moc.delete(password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}

struct VerifyFavoriteLogin: View {
    
    @Binding var showCopy: Bool
    
    @Binding var countLoginsFav : Int
    @Binding var showModalLogin: Bool
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showLink = false
    @State private var iconLink = ""
    @State private var activeLink = false
    
    @State var goForward = false
    @State var goBack = false
    @State var reloadPage = false
    @State var webTitle = ""
    
    let login: Login
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if self.showLink == false {
                    ZStack{
                        HStack{
                            ZStack{
                                HStack{
                                    Spacer()
                                    
                                    Image(systemName: self.login.fav ? "star.fill" : "star")
                                        .foregroundColor(Color("Color5"))
                                        .padding(.trailing, 20)
                                        .onTapGesture {
                                            self.activeSwipeLeft = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                                self.login.fav.toggle()
                                                try? moc.save()
                                            }
                                        }
                                    
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.red)
                                        .padding(.trailing, 30)
                                        .onTapGesture {
                                            self.deleteLogin()
                                            self.activeSwipeLeft = false
                                        }
                                }
                                .frame(height: 47)
                                .background(Color.gray.opacity(0.1))
                                
                                
                                HStack{
                                    ZStack{
                                        HStack{
                                            ZStack{
                                                Image(systemName: "link")
                                                    .font(.system(size: 14.5, weight: .medium))
                                                    .foregroundColor(Color("Color4"))
                                                    .padding()
                                                    .frame(width: 25, height: 25)
                                                
                                                Image(iconLink)
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                    .cornerRadius(5)
                                            }
                                        
                                            Text(login.loginTitle ?? "")
                                                .font(.system(size: 15))
                                        
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                        swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                                    }
                                }
                                .frame(height: 47)
                                .background(Color("Color7"))
                                .offset(x: self.activeSwipeLeft ? -130 : 0)
                                .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                                .onTapGesture {
                                    if self.activeSwipeLeft != true {
                                        self.activeAnimation = false
                                        self.showLink.toggle()
                                    } else {
                                        self.activeSwipeLeft = false
                                    }
                                }
                            }
                        }
                        .background(Color("Color7"))
                        .frame(height: 47)
                        .onTapGesture {
                            self.showLink = true
                        }
                        .onAppear{
                            self.countLoginsFav += 1
                        }
                    }
                } else {
                    
                    VStack(spacing: 0){
                        HStack{
                            
                            ZStack{
                                Image(systemName: "link")
                                    .font(.system(size: 14.5, weight: .medium))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 25, height: 25)
                                
                                Image(iconLink)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .cornerRadius(5)
                            }
                            
                            Text(login.loginTitle ?? "")
                                .lineLimit(1)
                                .foregroundColor(Color("Color4"))
                                .font(.system(size: 15, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 14))
                                .opacity(0.3)
                            
                        }
                        .background(Color("Color7"))
                        .frame(height: 47)
                        .padding(.horizontal)
                        .onTapGesture {
                            self.showModalLogin.toggle()
                        }
                        .fullScreenCover(isPresented: self.$showModalLogin){
                            NavigationView{
                                DetailLoginView(login: login).environment(\.managedObjectContext, self.moc)
                            }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color5"))
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        HStack(){
                                            Text("Login")
                                                .foregroundColor(Color("Color7"))
                                                .minimumScaleFactor(1)
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.leading)
                                .onTapGesture {
                                    self.activeLink.toggle()
                                    
                                }
                                .fullScreenCover(isPresented: $activeLink) {
                                    NavigationView{
                                        VStack{
                                            HStack{
                                                HStack{
                                                    
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            self.activeLink.toggle()
                                                        }
                                                }
                                                
                                                Spacer(minLength: 0)
                                                
                                                HStack{
                                                    Spacer(minLength: 0)
                                                    
                                                    Image(systemName: "lock")
                                                        .foregroundColor(Color.white)
                                                        .opacity(self.webTitle != "" ? 1 : 0)
                                                    Text(webTitle)
                                                        .lineLimit(1)
                                                        .foregroundColor(Color.white)
                                                    
                                                    Spacer(minLength: 0)
                                                }
                                                .frame(maxWidth: 200)
                                                .padding(.horizontal)
                                                
                                                Spacer()
                                                
                                                HStack{
                                                    
                                                    Image(systemName: "arrow.clockwise")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            self.reloadPage.toggle()
                                                        }
                                                }
                                            }
                                            .frame(height: 47)
                                            .padding(.horizontal)
                                            .background(Color.black.opacity(0.5))
                                            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                            .ignoresSafeArea(.all, edges: .top)
                                            
                                            Spacer(minLength: 0)
                                            
                                            WebView(goForward: $goForward, goBack: $goBack,reloadPage: $reloadPage, webTitle: $webTitle, url: "https://\(self.login.loginSite ?? "")")
                                            
                                            Spacer(minLength: 0)
                                            
                                            ZStack{
                                                Rectangle()
                                                    .frame(height: 47)
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                HStack{
                                                    Image(systemName: "arrow.left")
                                                        .foregroundColor(Color.white)
                                                        .onTapGesture{
                                                            print("goBack")
                                                            self.goBack = true
                                                        }
                                                    
                                                    Image(systemName: "arrow.right")
                                                        .foregroundColor(Color.white)
                                                        .padding(.leading,40)
                                                        .onTapGesture{
                                                            print("goForward")
                                                            self.goForward = true
                                                        }
                                                    Spacer(minLength: 0)
                                                }
                                                .padding(.horizontal)
                                            }
                                            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                                            
                                        }
                                        .ignoresSafeArea(.all, edges: .bottom)
                                        .ignoresSafeArea(.all, edges: .top)
                                        .navigationBarHidden(true)
                                    }
                                }
                                
                                
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("USERNAME")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.login.loginUsername ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.login.loginUsername
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("PASSWORD")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.login.loginPassword ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                    
                                }
                                .padding(.trailing)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.login.loginPassword
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(Color.white.opacity(0.01))
                }
                Divider()
                    .padding(.leading)
            }
            .onAppear {
                self.iconLink = "\(self.login.loginTitle ?? "")"
            }
        }
    }
    func deleteLogin(){
        moc.delete(login)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}

struct VerifyFavoriteBankAccount: View {
    
    @Binding var showCopy: Bool
    @Binding var countBanksFav : Int
    @Binding var showModalBank: Bool
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showLink = false
    @State private var iconLink = ""
    
    let bankAccount: BankAccount
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if self.showLink == false {
                    ZStack{
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: self.bankAccount.fav ? "star.fill" : "star")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.bankAccount.fav.toggle()
                                        try? moc.save()
                                    }
                                }
                            
                            Image(systemName: "trash")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 30)
                                .onTapGesture {
                                    self.deleteBankAccount()
                                    self.activeSwipeLeft = false
                                }
                        }
                        .frame(height: 47)
                        .background(Color.gray.opacity(0.1))
                        
                        HStack{
                            ZStack{
                                HStack{
                                    ZStack{
                                        Image(systemName: "briefcase")
                                            .font(.system(size: 15))
                                            .foregroundColor(Color("Color4"))
                                            .padding()
                                            .frame(width: 28, height: 28)
                                        
                                        Image(iconLink)
                                            .resizable()
                                            .renderingMode(.original)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                            .cornerRadius(5)
                                    }
                                    
                                    Text(bankAccount.bankName ?? "")
                                        .font(.system(size: 15))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                swipeGesture(activeSwipeLeft: self.$activeSwipeLeft, activeAnimation: self.$activeAnimation)
                            }
                            
                        }
                        .frame(height: 47)
                        .background(Color("Color7"))
                        .offset(x: self.activeSwipeLeft ? -130 : 0)
                        .animation(self.activeAnimation  ? .spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0) : .none)
                        .onTapGesture {
                            if self.activeSwipeLeft != true {
                                self.activeAnimation = false
                                self.showLink.toggle()
                            } else {
                                self.activeSwipeLeft = false
                            }
                            
                        }
                        .onAppear{
                            self.countBanksFav += 1
                        }
                    }
                } else {
                    VStack(spacing: 0){
                        HStack{
                            Image(systemName: "briefcase")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Color4"))
                                .padding()
                                .frame(width: 28, height: 28)
                            
                            Text(bankAccount.bankName ?? "")
                                .lineLimit(1)
                                .foregroundColor(Color("Color4"))
                                .font(.system(size: 15, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 14))
                                .opacity(0.3)
                            
                        }
                        .frame(height: 47)
                        .padding(.horizontal)
                        .onTapGesture {
                            self.showModalBank.toggle()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("ACCOUNT NAME")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.bankAccount.bankName ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.leading)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.bankAccount.bankName
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("ACCOUNT Nº")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.bankAccount.bankNo ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                    
                                }
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.bankAccount.bankNo
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("IBAN")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.bankAccount.bankIBAN ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                    
                                }
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.bankAccount.bankIBAN
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("SWIFT")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.bankAccount.bankSWIFT ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                    
                                }
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.bankAccount.bankSWIFT
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(Color("Color8"))
                                        .opacity(0.13)
                                        .frame(minWidth: 100)
                                        .frame(height: 60)
                                        .cornerRadius(5)
                                    VStack(spacing: 0){
                                        Text("TYPE")
                                            .font(.system(size: 10, weight: .medium))
                                            .opacity(0.6)
                                            .padding(.top)
                                            .padding(.bottom, 10)
                                            .padding(.horizontal, 40)
                                        HStack{
                                            Text("\(self.bankAccount.bankType ?? "")")
                                                .font(.system(size: 15, weight: .medium))
                                                .lineLimit(1)
                                                .padding(.horizontal, 40)
                                                .padding(.bottom)
                                        }
                                    }
                                    .fixedSize()
                                }
                                .padding(.trailing)
                                .onTapGesture {
                                    self.showCopy = true
                                    UIPasteboard.general.string = self.bankAccount.bankType
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                
                            }
                            .padding(.bottom)
                        }
                    }
                    .background(Color.white.opacity(0.01))
                }
                Divider()
                    .padding(.leading)
            }
        }
    }
    
    func deleteBankAccount(){
        moc.delete(bankAccount)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
}

struct swipeGesture : UIViewRepresentable {
    
    @Binding var activeSwipeLeft : Bool
    @Binding var activeAnimation : Bool
    
    func makeCoordinator() -> swipeGesture.Coordinator {
        return swipeGesture.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<swipeGesture>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let left = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.left))
        left.direction = .left
        
        let right = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.right))
        right.direction = .right
        
        view.addGestureRecognizer(left)
        view.addGestureRecognizer(right)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<swipeGesture>) {
        
    }
    
    class Coordinator : NSObject {
        
        var parent : swipeGesture
        init(parent1 : swipeGesture ) {
            parent = parent1
        }
        
        @objc func left(){
            print("left swipe")
            parent.activeSwipeLeft = true
            parent.activeAnimation = true
        }
        
        @objc func right(){
            print("right swipe")
            parent.activeSwipeLeft = false
        }
    }
}


