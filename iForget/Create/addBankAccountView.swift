//
//  addBankAccountView.swift
//  iForget
//
//  Created by Vinícius Lopes on 07/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addBankAccountView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var bankName = ""
    @State private var bankNo = ""
    @State private var bankIBAN = ""
    @State private var bankSWIFT = ""
    @State private var bankType = ""
    @State private var bankMore = ""
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment:.leading){
                        Group{
                            Section{
                                Text("ACCOUNT NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Name", text: $bankName)
                                    .textContentType(.organizationName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                                .opacity(0.5)
                            Section{
                                Text("ACCOUNT Nº")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Nº", text: $bankNo)
                                    .font(.system(size: 16))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("IBAN")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("IBAN", text: $bankIBAN)
                                    .font(.system(size: 16))
                                    .autocapitalization(.allCharacters)
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("SWIFT Nº")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Swift Nº", text: $bankSWIFT)
                                    .font(.system(size: 16))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("ACCOUNT TYPE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Type...", text: $bankType)
                                    .font(.system(size: 16))
                            }
                            Divider()
                            .opacity(0.5)
                        }
                        Section{
                            Text("ADDITIONAL INFORMATION")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("ex: Card for...", text: $bankMore)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                    }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom, 35)
                    
                Spacer()
            }
            .modifier(DisableModalDismiss(disabled: true))
            .navigationBarTitle("New Bank Account", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                    let newBankAccount = BankAccount(context: self.moc)
                                
                    newBankAccount.bankName = self.bankName
                    newBankAccount.bankNo = self.bankNo
                    newBankAccount.bankIBAN = self.bankIBAN
                    newBankAccount.bankSWIFT = self.bankSWIFT
                    newBankAccount.bankType = self.bankType
                    newBankAccount.bankMore = self.bankMore
                            
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
}


struct addBankAccountView_Previews: PreviewProvider {
    static var previews: some View {
        addBankAccountView()
    }
}
