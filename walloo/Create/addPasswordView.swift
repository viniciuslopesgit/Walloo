//
//  addPassword.swift
//  iForget
//
//  Created by Vinícius Lopes on 06/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addPasswordView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var passwordTitle = ""
    @State private var passwordCode = ""
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    Section{
                        Text("TITLE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        TextField("Title", text: $passwordTitle)
                            .font(.system(size: 16))
                    }
                    Divider()
                        .opacity(0.5)
                    Section{
                        Text("PASSWORD")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                        
                        TextField("Password", text: $passwordCode)
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
        .navigationBarTitle(Text("New Password"), displayMode: .inline)
        .navigationBarItems(
            trailing:
            Button(action: {
                let newPassword = Password(context: self.moc)
                
                newPassword.passwordTitle = self.passwordTitle
                newPassword.passwordCode = self.passwordCode
                
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Save")
                    .font(.body)
                    .foregroundColor(Color("Color5"))
            }
            
        )
    }
}

struct addPassword_Previews: PreviewProvider {
    static var previews: some View {
        addPasswordView()
    }
}
