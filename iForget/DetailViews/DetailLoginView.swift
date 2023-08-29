//
//  DetailLoginView.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import CoreData
import SwiftUI

struct DetailLoginView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var showCopy: Bool = false
    @State var copyName = ""
    
    @State private var showOptions = false
    @State private var shareSheetShowing = false
    @State private var activeWebView = false
    
    @State private var textFav = ""
    @State private var shareText = ""
    
    @State var editTitle = ""
    @State var editWebsite = ""
    @State var editUsername = ""
    @State var editPassword = ""
    
    @State var goForward = false
    @State var goBack = false
    
    let login: Login
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Text("Copied \(copyName) to clipboard")
                        .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                        .font(.system(size: 14, weight: .medium))
                        .padding()
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
            
            if self.shareSheetShowing{
                ActivityViewController(text: self.$shareText, showing: $shareSheetShowing)
                    .frame(width: 0, height: 0)
            }
            
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        VStack(alignment: .leading){
                            Section{
                                Text("TITLE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                HStack{
                                    TextField("", text: self.$editTitle)
                                        .font(.system(size: 15))
                                    Spacer()
                                }
                            }
                            .onAppear {
                                self.editTitle = self.login.loginTitle ?? ""
                                self.editWebsite = self.login.loginSite ?? ""
                                self.editUsername = self.login.loginUsername ?? ""
                                self.editPassword = self.login.loginPassword ?? ""
                            }
                            
                        }
                        .padding(.leading)
                        .background(Color("Color7"))
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        VStack(alignment: .leading){
                            Section{
                                Text("WEBSITE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                HStack{
                                    Text("https://")
                                        .font(.system(size: 16))
                                        .opacity(0.7)
                                        .padding(.trailing, 10)
                                    
                                    TextField("", text: self.$editWebsite )
                                        .font(.system(size: 15))
                                        .autocapitalization(.none)
                                        .textContentType(.URL)
                                        .keyboardType(.URL)
                                        .disableAutocorrection(true)
                                    Spacer()
                                    
                                }
                            }
                            
                        }
                        .padding(.leading)
                        .background(Color("Color7"))
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        VStack(alignment: .leading){
                            Section{
                                Text("USERNAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                HStack{
                                    TextField("", text: self.$editUsername)
                                        .font(.system(size: 15))
                                        .textContentType(.username)
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding(.leading)
                        .background(Color("Color7"))
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        VStack(alignment: .leading){
                            Section{
                                Text("PASSWORD")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                HStack{
                                    TextField("", text: self.$editPassword)
                                        .font(.system(size: 15))
                                        .textContentType(.password)
                                    Spacer()
                                }
                                
                            }
                        }
                        .padding(.leading)
                        .background(Color("Color7"))
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                    }
                }
                HStack{
                    Button(action: {
                        self.saveEditandLogin()
                        self.activeWebView.toggle()
                    }){
                        ZStack{
                            Color("ColorButtonLogin")
                                .frame(height: 47)
                            HStack{
                                Text("Login")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.saveEdit()
                    }){
                        Text("Save")
                            .font(.body)
                            .foregroundColor(Color("Color5"))
                    }
                ,trailing:
                    HStack{
                        if self.login.fav {
                            Image(systemName: "star")
                                .font(.body)
                                .foregroundColor(Color("Color5"))
                                .padding([.vertical, .trailing])
                        }
                            
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            self.showOptions.toggle()
                            
                            if self.login.fav == false {
                                self.textFav = "Add to Favourites"
                            } else {
                                self.textFav = "Remove from Favourites"
                            }
                        }){
                            Image(systemName: "ellipsis")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(Color("Color5"))
                        }
                        .padding(.vertical)
                    }
                .actionSheet(isPresented: $showOptions){
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Send Login")) {
                            self.shareSheetShowing.toggle()
                        },
                        .default(Text(textFav)) {
                            self.login.fav.toggle()
                            try? self.moc.save()
                        },
                        .destructive(Text("Move to Trash")) {
                            self.deleteLogin()
                        },
                        .cancel()
                    ])
                }
            )
        }
        .fullScreenCover(isPresented: self.$activeWebView){
          /*
            NavigationView{
                VStack(spacing: 0){
                    WebView(goForward: $goForward, goBack: $goBack, url: "https://\(self.login.loginSite ?? "")")
                        .navigationBarTitle("")
                        .navigationBarItems(
                        leading:
                            HStack{
                                Button(action: {
                                    self.activeWebView.toggle()
                                }){
                                    Text("Done")
                                        .font(.body)
                                        .foregroundColor(Color("Color5"))
                                }
                                
                                NavLogo(login: login)
                                    .padding(.leading, 30)
                                
                                
                            }
                        )
                }
                
            }
            
            */
            
        }
        .onAppear{
            self.shareText = """
            Title: \(self.login.loginTitle ?? "")
            Username: \(self.login.loginUsername ?? "")
            Password: \(self.login.loginPassword ?? "")
            
            Sent by the iForget App
            """
        }
        .onDisappear{
            
            if self.login.loginPassword != "" && self.login.loginPassword?.count ?? 0 < 10 {
                
                let content = UNMutableNotificationContent()
                
                content.title = "Security"
                content.body = "Your \(self.login.loginTitle ?? "") account is at risk. Change your password now!"
                content.sound = UNNotificationSound.default
                
                let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
                
                let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
                
                let categories = UNNotificationCategory(identifier: "actionLoginInside", actions: [open,cancel], intentIdentifiers: [])
                
                UNUserNotificationCenter.current().setNotificationCategories([categories])
                
                content.categoryIdentifier = "actionLoginInside"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600 , repeats: false)
                
                let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
            }
        }
    }
    func deleteLogin(){
        moc.delete(login)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    func saveEdit() {
        
        let editLogin = self.login
        
        editLogin.loginTitle = self.editTitle.trimmingCharacters(in: .whitespaces)
        editLogin.loginSite = self.editWebsite.trimmingCharacters(in: .whitespaces)
        editLogin.loginUsername = self.editUsername
        editLogin.loginPassword = self.editPassword
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
        
    }
    func saveEditandLogin() {
        
        let editLogin = self.login
        
        editLogin.loginTitle = self.editTitle.trimmingCharacters(in: .whitespaces)
        editLogin.loginSite = self.editWebsite.trimmingCharacters(in: .whitespaces)
        editLogin.loginUsername = self.editUsername
        editLogin.loginPassword = self.editPassword
        
        try? self.moc.save()
        
    }
}

struct DetailLoginView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let login = Login(context: moc)
        login.loginTitle = "Teste"
        login.loginSite = "teste.com"
        login.loginUsername = "teste@gmail.com"
        login.loginPassword = "teste123"
        
        return NavigationView{
            DetailLoginView(login: login)
        }.edgesIgnoringSafeArea(.top)
    }
}

