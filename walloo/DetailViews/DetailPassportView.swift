//
//  DetailPassportView.swift
//  iForget
//
//  Created by Vinícius Lopes on 25/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailPassportView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var height: CGFloat = 0
    
    @State var showCopy: Bool = false
    @State var copyName = ""
    
    @State private var showingDeleteAlert = false
    
    @State  var activeEdit = false
    
    let passport: Passport
    
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
                            Divider()
                                .padding(.top, 30)
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Type")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportType ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportType
                                self.copyName = "Type"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Issuing Country")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportIssuingCountry ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportIssuingCountry
                                self.copyName = "Issuing Country"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Passport Number")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportNo ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportNo
                                self.copyName = "Passport Nº"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Last Name")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportLastName ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportLastName
                                self.copyName = "Last Name"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Name")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportName ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportName
                                self.copyName = "Name"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Birth")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportBirth ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportBirth
                                self.copyName = "Birth"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Gender")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportSex ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportSex
                                self.copyName = "Gender"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Place of Birth")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportPlaceBirth ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportPlaceBirth
                                self.copyName = "Place of birth"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Filiation Mother")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportFiliationMother ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportFiliationMother
                                self.copyName = "Mother"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Filiation Father")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportFiliationFather ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportFiliationFather
                                self.copyName = "Father"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Date of Issue")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportDateIssue ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportDateIssue
                                self.copyName = "Issue"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Date of Expiry")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportDateExpiry ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportDateExpiry
                                self.copyName = "Expiry"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.leading)
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Authority")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    
                                    Text(self.passport.passportAuthority ?? "" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    Spacer()
                                }
                                .padding(.top, 5)
                                
                            }
                            .background(Color("Color1"))
                            .onTapGesture {
                                UIPasteboard.general.string = self.passport.passportAuthority
                                self.copyName = "Authority"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.showCopy = false
                                }
                            }
                            Divider()
                                .padding(.bottom, 35)
                        }
                    }
            }
        }
        .sheet(isPresented: $activeEdit){
            NavigationView{
                EditPassport(activeEdit: self.$activeEdit, passport: self.passport).environment(\.managedObjectContext, self.moc)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Done")
                        .font(.body)
                        .foregroundColor(Color("Color5"))
                }
            ,trailing:
            HStack{
                Button(action: {
                    self.showingDeleteAlert.toggle()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Color("Color5"))
                        .font(.body)
                }
                .padding(.vertical)
                .padding(.trailing)
                
                Button(action: {
                    self.activeEdit.toggle()
                }) {
                    Text("Edit")
                        .foregroundColor(Color("Color5"))
                        .font(.body)
                }
                .padding(.vertical)
            }
        )
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete Passport"), message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")){
                    self.deletePassport()
                  }, secondaryButton: .cancel()
            )
        }
    }
    
    func deletePassport(){
        moc.delete(passport)
        
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
    
}


struct DetailPassportView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let passport = Passport(context: moc)
        
        return NavigationView{
            DetailPassportView(passport: passport)
        }.edgesIgnoringSafeArea(.top)
        
    }
    
}

