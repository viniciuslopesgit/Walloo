//
//  addLoginView.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI
import UserNotifications

struct addLoginView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var loginTitle: String = ""
    @State private var loginSite: String = ""
    @State private var loginUsername: String = ""
    @State private var loginPassword: String = ""
    
    @State private var isPassValid = true
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    Section{
                        Text("TITLE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        TextField("Title", text: $loginTitle)
                            .font(.system(size: 16, weight: .medium))
                    }
                    Divider()
                        .opacity(0.5)
                    Section{
                        Text("WEB SITE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        HStack{
                            
                            Text("https://")
                                .font(.system(size: 16))
                                .opacity(0.7)
                                .padding(.trailing, 10)
                            
                            TextField("example.com", text: $loginSite)
                                .disableAutocorrection(true)
                                .textContentType(.URL)
                                .keyboardType(.URL)
                                .autocapitalization(.none)
                                .font(.system(size: 16))
                        }
                    }
                    Divider()
                    .opacity(0.5)
                    Section{
                        Text("USERNAME")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        TextField("@", text: $loginUsername)
                            .keyboardType(.emailAddress)
                            .textContentType(.username)
                            .font(.system(size: 16))
                            .autocapitalization(.none)
                    }
                    Divider()
                    .opacity(0.5)
                    Section{
                        Text("PASSWORD")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        TextField("Password", text: $loginPassword, onEditingChanged:  { (isChanged) in
                            if !isChanged {
                                if self.textFieldValidatorPass(self.loginPassword) {
                                    print("ok")
                                }
                            }
                        })
                            
                            
                            .textContentType(.password)
                            .font(.system(size: 16))
                    }
                    Divider()
                    .opacity(0.5)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
            }
            .modifier(DisableModalDismiss(disabled: true))
        }
        .navigationBarTitle("New Login", displayMode: .inline)
        .navigationBarItems(
                trailing:
            Button(action: {
                
                self.saveAll()
            }){
                Text("Save")
                    .font(.body)
                    .foregroundColor(Color("Color5"))
                    
            }
        )
    }
    func saveAll() {
        
        //NOTIFICATION
        
        if self.loginPassword.count < 10 {
            
            let content = UNMutableNotificationContent()
            
            content.title = "Security"
            content.body = "Your \(self.loginTitle) account is at risk. Change your password now!"
            content.sound = UNNotificationSound.default
            
            let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
            
            let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
            
            let categories = UNNotificationCategory(identifier: "actionLoginCreate", actions: [open,cancel], intentIdentifiers: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([categories])
            
            content.categoryIdentifier = "actionLoginCreate"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400 , repeats: false)
            
            let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        }
        
        
        
        let newLogin = Login(context: self.moc)
        
        newLogin.loginTitle = self.loginTitle.trimmingCharacters(in: .whitespaces)
        newLogin.loginSite = self.loginSite.trimmingCharacters(in: .whitespaces)
        newLogin.loginUsername = self.loginUsername
        newLogin.loginPassword = self.loginPassword
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func textFieldValidatorPass(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct addLoginView_Previews: PreviewProvider {
    static var previews: some View {
        addLoginView()
    }
}
