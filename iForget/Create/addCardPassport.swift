//
//  addCardPassport.swift
//  iForget
//
//  Created by Vinícius Lopes on 25/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addCardPassport: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var passportType = ""
    @State private var passportInssuingCountry = ""
    @State private var passportNo = ""
    @State private var passportLastName = ""
    @State private var passportName = ""
    @State private var passportNacionality = ""
    @State private var passportBirth = ""
    @State private var passportSex = ""
    @State private var passportPlaceBirth = ""
    @State private var passportFiliationMother = ""
    @State private var passportFiliationFather = ""
    @State private var passportDateIssue = ""
    @State private var passportDateExpiry = ""
    @State private var passportAuthority = ""
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: true){
                VStack{
                    VStack(alignment: .leading){
                        Section {
                            Text("TYPE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Type", text: $passportType)
                            .font(.system(size: 16, weight: .medium))
                                .autocapitalization(.allCharacters)
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("ISSUING COUNTRY")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Issuing Country", text: $passportInssuingCountry)
                                .textContentType(.location)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("PASSPORT Nº")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("FS2443...", text: $passportNo)
                            .font(.system(size: 16, weight: .medium))
                                .autocapitalization(.allCharacters)
                        }
                        Divider()
                        .opacity(0.5)
                    }
                    VStack(alignment: .leading){
                        Section{
                            Text("LAST NAME")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Last Name", text: $passportLastName)
                                .textContentType(.familyName)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("NAME")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Name", text: $passportName)
                                .textContentType(.name)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("BIRTH")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("MM/YY", text: $passportBirth)
                            .font(.system(size: 16, weight: .medium))
                            
                        }
                    }
                    VStack(alignment: .leading){
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("GENDER")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("M or F", text: $passportSex)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("PLACE OF BIRTH")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Place of birth", text: $passportPlaceBirth)
                                .textContentType(.location)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("FILIATION MOTHER")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Mother", text: $passportFiliationMother)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("FILIATION FATHER")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Father", text: $passportFiliationFather)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                    }
                    VStack(alignment: .leading){
                        Section{
                            Text("DATE OF ISSUE")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("MM/YY", text: $passportDateIssue)
                            .font(.system(size: 16, weight: .medium))
                            
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("DATE OF EXPIRY")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("MM/YY", text: $passportDateExpiry)
                            .font(.system(size: 16, weight: .medium))
                            
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("AUTHORITY")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Authority", text: $passportAuthority)
                            .font(.system(size: 16, weight: .medium))
                                .autocapitalization(.allCharacters)
                        }
                        Divider()
                        .opacity(0.5)
                    }
                }
                .padding(.leading)
                .padding(.top)
                .padding(.bottom, 35)
                Spacer()
            }
            .modifier(DisableModalDismiss(disabled: true))
            .navigationBarTitle("New Passport", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    
                    let newPassport = Passport(context: self.moc)
                    
                    newPassport.passportType = self.passportType
                    newPassport.passportIssuingCountry = self.passportInssuingCountry
                    newPassport.passportNo = self.passportNo
                    newPassport.passportLastName = self.passportLastName
                    newPassport.passportName = self.passportName
                    newPassport.passportNacionality = self.passportNacionality
                    newPassport.passportBirth = self.passportBirth
                    newPassport.passportSex = self.passportSex
                    newPassport.passportPlaceBirth = self.passportPlaceBirth
                    newPassport.passportFiliationMother = self.passportFiliationMother
                    newPassport.passportFiliationFather = self.passportFiliationFather
                    newPassport.passportDateIssue = self.passportDateIssue
                    newPassport.passportDateExpiry = self.passportDateExpiry
                    newPassport.passportAuthority = self.passportAuthority
                    
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

struct addCardPassport_Previews: PreviewProvider {
    static var previews: some View {
        addCardPassport()
    }
}
