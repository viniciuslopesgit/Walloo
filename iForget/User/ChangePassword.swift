//
//  ChangePassword.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import KeychainSwift

struct ChangePassword: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var value: CGFloat = 0
    @State private var keyboardActive: Bool = false
    
    @State var createPassword: String = ""
    @State var createPasswordAgain: String = ""
    @State var passwordUser: String = ""
    @State var passwordOld: String = ""
    @State var showError: Bool = false
    
    @State private var errorOldPass: String = "Incorrect old password Those passwords didn't match. Try again."
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Section{
                    Text("OLD PASSWORD")
                        .font(.system(size: 10, weight: .medium))
                        .opacity(0.6)
                    SecureField("Old Password", text: $passwordOld)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                        
                }
                Divider()
                Section{
                    Text("NEW PASSWORD")
                        .font(.system(size: 10, weight: .medium))
                        .opacity(0.6)
                    SecureField("New Password", text: $createPassword)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                }
                Divider()
                Section{
                    Text("CONFIRM")
                        .font(.system(size: 10, weight: .medium))
                        .opacity(0.6)
                
                    SecureField("Confirm", text: $createPasswordAgain)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)))
                }
                Divider()
            }
            .padding(.top)
            .padding(.leading)
            HStack {
                Text(errorOldPass)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.red)
                    .opacity(showError ? 1 : 0)
                Spacer()
            }
            .padding(.leading)
            
            Spacer()
            
            VStack{
                Text("Change Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.white)
            }
            .frame(width: 270, height: 47)
            .background(Color("ColorButtonLogin"))
            .padding()
            .offset(y: -self.value)
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 1))
            .onTapGesture {
                if self.createPassword.count >= 6 {
                    self.showError = false
                    let keychain = KeychainSwift()
                    self.passwordUser = keychain.get("my key") ?? ""
                    
                    if self.passwordUser == self.passwordOld {
                        if self.createPassword == self.createPasswordAgain  {
                            self.passwordUser = self.createPasswordAgain
                            self.guardKey()
                            self.presentationMode.wrappedValue.dismiss()
                        } else if self.createPassword != self.createPasswordAgain {
                            self.errorOldPass = "Those passwords didn't match. Try again."
                            self.showError = true
                        }
                        
                    } else  if self.passwordUser != self.passwordOld{
                        self.errorOldPass = "Incorrect old password. Try again."
                        self.showError = true
                    }
                } else if self.createPassword.count < 6 {
                    self.errorOldPass = "Use 6 or more characters in a mixture of letters, numbers and symbols."
                    self.showError = true
                }
            }
        }
        .navigationBarTitle("Password", displayMode: .inline)
        .onAppear{
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                self.value = height
                self.keyboardActive = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                
                self.value = 0
                self.keyboardActive = false
            }
        }
    }
    func guardKey() {
        
        let keychain = KeychainSwift()
        keychain.delete("my key")
        keychain.set(self.passwordUser, forKey: "my key")
        
        print("save")
        
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
