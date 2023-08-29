//
//  DetailBankAccountView.swift
//  iForget
//
//  Created by Vinícius Lopes on 07/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import CoreData
import SwiftUI

struct DetailBankAccountView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var textFav = ""
    @State private var textBankShare = ""
    
    @State private var shareSheetShowing = false
    
    @State var showCopy = false
    @State var showOptions = false
    
    @State var copyName = ""
    
    @State var editName = ""
    @State var editNo = ""
    @State var editIBAN = ""
    @State var editSWIFT = ""
    @State var editTYPE = ""
    @State var editAddInfo = ""
    
    let bankAccount: BankAccount
    
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
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                Text("ACCOUNT NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                    .padding(.top)
                                HStack{
                                    TextField("", text: self.$editName)
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .onAppear {
                                self.editName = self.bankAccount.bankName ?? ""
                                self.editNo = self.bankAccount.bankNo ?? ""
                                self.editIBAN = self.bankAccount.bankIBAN ?? ""
                                self.editSWIFT = self.bankAccount.bankSWIFT ?? ""
                                self.editTYPE = self.bankAccount.bankIBAN ?? ""
                                self.editAddInfo = self.bankAccount.bankMore ?? ""
                                
                                self.textBankShare =
                                """
                                Bank Account Name: \(self.bankAccount.bankName ?? "" )
                                Bank Account Nº: \(self.bankAccount.bankNo ?? "" )
                                IBAN: \(self.bankAccount.bankIBAN ?? "" )
                                SWIFT: \(self.bankAccount.bankSWIFT ?? "")
                                TYPE: \(self.bankAccount.bankType ?? "")
                                Additional Information: \(self.bankAccount.bankMore ?? "")
                                
                                Sent by the iForget app
                                
                                """
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                Text("ACCOUNT Nº")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editNo)
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                Text("IBAN")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editIBAN)
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                Text("SWIFT")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editSWIFT)
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                Text("TYPE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editTYPE)
                                        .font(.system(size: 15))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                                .padding(.leading)
                                .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0){
                                Text("ADDITIONAL INFORMATION")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editAddInfo)
                                        .font(.system(size: 15))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color7"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                        }
                        
                }
            }
            if self.shareSheetShowing{
            ActivityViewController(text: self.$textBankShare, showing: $shareSheetShowing)
                   .frame(width: 0, height: 0)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(action: {
                    self.saveBankEdit()
                }){
                    Text("Save")
                        .foregroundColor(Color("Color5"))
                        .font(.body)
                }
            ,trailing:
            HStack{
                if self.bankAccount.fav {
                    Image(systemName: "star")
                        .font(.body)
                        .foregroundColor(Color("Color5"))
                        .padding([.vertical, .trailing])
                }
                
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.showOptions.toggle()
                    
                    if self.bankAccount.fav == false {
                        self.textFav = "Add to Favourites"
                    } else {
                        self.textFav = "Remove from Favourites"
                    }
                    
                }){
                   Image(systemName: "ellipsis")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(Color("Color5"))
                }
            }
            .padding(.vertical)
            .actionSheet(isPresented: $showOptions){
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Send Bank Account")) {
                            self.shareSheetShowing.toggle()
                        },
                        .default(Text(textFav)) {
                            self.bankAccount.fav.toggle()
                            try? self.moc.save()
                        },
                        .destructive(Text("Move to Trash")) {
                            self.deleteBankAccount()
                        },
                        .cancel()
                    ])
            }
        )
    }
    
    func deleteBankAccount(){
        moc.delete(bankAccount)
        
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
    func saveBankEdit() {
        
        let editBank = self.bankAccount
        
        editBank.bankName = self.editName
        editBank.bankNo = self.editNo
        editBank.bankIBAN = self.editIBAN
        editBank.bankSWIFT = self.editSWIFT
        editBank.bankType = self.editTYPE
        editBank.bankMore = self.editAddInfo
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct DetailBankAccountView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let bankAccount = BankAccount(context: moc)
        bankAccount.bankName = "Teste"
        bankAccount.bankNo = "123123123"
        bankAccount.bankIBAN = "12123123"
        bankAccount.bankSWIFT = "4123123123"
        bankAccount.bankType = "Polpança"
        bankAccount.bankMore = "Novo banco que eu fiz um novo cartão"
        
        return NavigationView{
            DetailBankAccountView(bankAccount: bankAccount)
        }.edgesIgnoringSafeArea(.top)
    }
}
