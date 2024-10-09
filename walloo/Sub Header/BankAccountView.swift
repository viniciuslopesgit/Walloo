//
//  BankAccountView.swift
//  iForget
//
//  Created by Vinícius Lopes on 07/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct BankAccountView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: BankAccount.entity(), sortDescriptors:[
                    NSSortDescriptor(keyPath: \BankAccount.bankName, ascending: true)])
    var bankAccount: FetchedResults<BankAccount>
    
    @State var showCopy = false
    
    @State var goSecondOnboard = false
    @State var showNews = false
    @State var showUpgrade = false
    
    var body: some View {
        ScrollView(.vertical){
            ZStack{
                VStack{
                    Spacer()
                    HStack{
                        Text("Copied ***** to clipboard")
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
                
                LazyVStack{
                    ForEach(bankAccount, id: \.self) {bankAccount in
                        BankAccounts( showCopy: self.$showCopy, bankAccount: bankAccount).environment(\.managedObjectContext, self.moc)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .navigationBarTitle("Bank Accounts", displayMode: .inline)
        }
    }
}


struct BankAccountView_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountView()
    }
}

struct BankAccounts: View {
    
    @Binding var showCopy: Bool
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var showLink = false
    @State private var activeEdit = false
    
    @State var activeSwipeLeft = false
    @State var activeAnimation = false
    
    @State var shareText = ""
    @State var shareSheetShowing = false

    @ObservedObject var bankAccount: BankAccount
    
    var body: some View {
        
        VStack(spacing: 0){
            if self.showLink == false {
                HStack{
                    ZStack{
                        
                        if self.shareSheetShowing{
                            ActivityViewController(text: self.$shareText, showing: $shareSheetShowing)
                                .frame(width: 0, height: 0)
                        }
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("Color5"))
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    self.refreshShareText()
                                    self.activeSwipeLeft = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                        self.shareSheetShowing.toggle()
                                    }
                                }
                            
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
                                    Image(systemName: "briefcase")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color("Color4"))
                                        .frame(width: 28, height: 28)
                                    
                                    Text(bankAccount.bankName ?? "")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 15))
                                    Spacer()
                                    
                                    if self.bankAccount.fav == true {
                                        Image(systemName: "star")
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
                }
                .contextMenu{
                    VStack{
                        Button(action: {
                            self.activeEdit.toggle()
                        }){
                            HStack{
                                Text("Edit")
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                            }
                        }
                        
                        Button(action: {
                            self.refreshShareText()
                            self.shareSheetShowing.toggle()
                        }){
                            HStack{
                                Text("Share")
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                            }
                        }
                        
                        Button(action: {
                            self.bankAccount.fav.toggle()
                            try? moc.save()
                        }){
                            HStack{
                                Text(self.bankAccount.fav ? "Remove from Favourites" : "Add to Favourites")
                                Image(systemName: "star")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Color4"))
                                    .padding()
                                    .frame(width: 28, height: 28)
                            }
                        }
                        
                        Button(action: {
                            self.deleteBankAccount()
                        }){
                            HStack{
                                Text("Move to Trash")
                                Image(systemName: "trash")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.red)
                                    .padding()
                                    .frame(width: 28, height: 28)
                            }
                        }
                    }
                }
                .background(Color("Color7"))
                .frame(height: 47)
                .onTapGesture {
                    if self.activeSwipeLeft != true {
                        self.activeAnimation = false
                        self.showLink = true
                    } else {
                        self.activeSwipeLeft.toggle()
                    }
                }
            } else {
                VStack(spacing: 0) {
                    HStack{
                        Image(systemName: "briefcase")
                            .font(.system(size: 15))
                            .foregroundColor(Color("Color4"))
                            .frame(width: 28, height: 28)
                        
                        Text(bankAccount.bankName ?? "")
                            .foregroundColor(Color("Color4"))
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        
                        if self.bankAccount.fav == true {
                            Image(systemName: "star")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Color5"))
                        }
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .font(.system(size: 14))
                            .opacity(0.3)
                    }
                    .frame(height: 47)
                    .background(Color.white.opacity(0.0001))
                    .padding(.horizontal)
                    .onTapGesture {
                        self.activeEdit.toggle()
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
                .background(Color.white.opacity(0.001))
            }
            Divider()
                .padding(.leading)
        }
        .fullScreenCover(isPresented: $activeEdit){
            NavigationView{
                DetailBankAccountView(bankAccount: bankAccount)
            }
        }
    }
    
    func deleteBankAccount(){
        moc.delete(bankAccount)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            try? self.moc.save()
        }
    }
    
    func refreshShareText(){
        self.shareText = """
        Account Name: \(self.bankAccount.bankName ?? "")
        Number: \(self.bankAccount.bankNo ?? "")
        IBAN: \(self.bankAccount.bankIBAN ?? "")
        SWIFT: \(self.bankAccount.bankSWIFT ?? "")
        Type: \(self.bankAccount.bankType ?? "")
        
        Sent by the iForget app
        """
    }
}
