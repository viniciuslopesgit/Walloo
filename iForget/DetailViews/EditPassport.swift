//
//  EditPassport.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/09/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct EditPassport: View {
    
    @Binding var activeEdit: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var editTYPE = ""
    @State var editIssuingCountry = ""
    @State var editPassportNo = ""
    @State var editLatName = ""
    @State var editName = ""
    @State var editBirth = ""
    @State var editGender = ""
    @State var editPlaceBirth = ""
    @State var editFiliationMother = ""
    @State var editFiliationFather = ""
    @State var editDateIssue = ""
    @State var editExpiry = ""
    @State var editAuthority = ""
    
    
    let passport : Passport
    
    var body: some View {
        ScrollView(.vertical){
                    VStack(alignment: .leading){
                        Group{
                            VStack(alignment: .leading){
                                Text("TYPE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                    .padding(.top)
                                HStack{
                                    TextField("", text: self.$editTYPE)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                                }
                            .onAppear {
                                self.editTYPE = self.passport.passportType ?? ""
                                self.editIssuingCountry = self.passport.passportIssuingCountry ?? ""
                                self.editPassportNo = self.passport.passportNo ?? ""
                                self.editLatName = self.passport.passportLastName ?? ""
                                self.editName = self.passport.passportLastName ?? ""
                                self.editBirth = self.passport.passportBirth ?? ""
                                self.editGender = self.passport.passportSex ?? ""
                                self.editPlaceBirth = self.passport.passportPlaceBirth ?? ""
                                self.editFiliationMother = self.passport.passportFiliationMother ?? ""
                                self.editFiliationFather = self.passport.passportFiliationFather ?? ""
                                self.editDateIssue = self.passport.passportDateIssue ?? ""
                                self.editExpiry = self.passport.passportDateExpiry ?? ""
                                self.editAuthority = self.passport.passportAuthority ?? ""
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("ISSUING COUNTRY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editIssuingCountry)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading){
                                Text("PASSPORT Nº")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editPassportNo)
                                        .font(.system(size: 16, weight: .medium))
                                        .autocapitalization(.allCharacters)
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("LAST NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editLatName)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editName)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("BIRTH")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editBirth)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("GENDER")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editGender)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading){
                                Text("PLACE OF BIRTH")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editPlaceBirth)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                        }
                        Group{
                            VStack(alignment: .leading){
                                Text("FILIATION MOTHER")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editFiliationMother)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("FILIATION FATHER")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editFiliationFather)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("DATE OF ISSUE")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editDateIssue)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("DATE OF EXPIRY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editExpiry)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                            VStack(alignment: .leading){
                                Text("AUTHORITY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                    .padding(.leading)
                                HStack{
                                    TextField("", text: self.$editAuthority)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                            }
                            .background(Color("Color1"))
                            .frame(minHeight: 47)
                            Divider()
                            .opacity(0.5)
                                .padding(.leading)
                                .padding(.bottom, 35)
                        }
                        
                    }
            }
        .navigationBarTitle("Passport", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.activeEdit = false
                self.saveEdit()
            }){
                Text("Save")
                    .foregroundColor(Color("Color5"))
                    .font(.body)
            }
            .padding(.vertical)
        )
    }
    func saveEdit() {
        let editPassport = self.passport
        
        editPassport.passportType = self.editTYPE
        editPassport.passportIssuingCountry = self.editIssuingCountry
        editPassport.passportNo = self.editPassportNo
        editPassport.passportLastName = self.editLatName
        editPassport.passportName = self.editName
        editPassport.passportBirth = self.editBirth
        editPassport.passportSex = self.editGender
        editPassport.passportPlaceBirth = self.editPlaceBirth
        editPassport.passportFiliationMother = self.editFiliationMother
        editPassport.passportFiliationFather = self.editFiliationFather
        editPassport.passportDateIssue = self.editDateIssue
        editPassport.passportDateExpiry = self.editExpiry
        editPassport.passportAuthority = self.editAuthority
        
        try? self.moc.save()
    }
}

