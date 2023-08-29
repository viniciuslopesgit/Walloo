//
//  EditCardID.swift
//  iForget
//
//  Created by Vinícius Lopes on 12/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct EditCardID: View {
    
    @Binding var activeEdit: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    static let sexChoose = ["Female", "Male"]
    
    @State private var show = false
    
    @State var editExistImage = 0
    
    @State var editIdentitylastName = ""
    @State var editIdentityName = ""
    @State var editIdentityFiliationMother = ""
    @State var editIdentityFiliationFather = ""
    @State var editIdentitySex = 0
    @State var editIdentityHeight = ""
    @State var editIdentityNationality = ""
    @State var editIdentityDateOfBirth = ""
    @State var editIdentityNumber = ""
    @State var editIdentityValid = ""
    @State var editIdentityMore = ""
    @State var editImage: Data = .init(count: 0)
    
    let identityNationalitys = ["Brasil", "Portugal", "Alemanha"]
    
    let cardID : CardID
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                        Group{
                            ZStack{
                                Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                                HStack{
                                    Spacer()
                                    VStack{
                                        if self.editImage.count != 0 {
                                            Button(action:{
                                                self.show = true
                                            }){
                                                Image(data: self.editImage, placeholder: "")
                                                    .resizable()
                                                    .renderingMode(.original)
                                                    .aspectRatio(contentMode: .fill)
                                                    .clipShape(Rectangle())
                                                    .frame(width: 90, height: 100)
                                                    .cornerRadius(6)
                                            }
                                        } else {
                                            Button(action: {
                                                self.show = true
                                            }){
                                                ZStack{
                                                    Rectangle()
                                                        .foregroundColor(Color(#colorLiteral(red: 0.9164912565, green: 0.9164912565, blue: 0.9164912565, alpha: 1)))
                                                        .frame(width: 90, height: 100)
                                                        .cornerRadius(6)
                                                    Image(systemName: "photo.fill")
                                                        .font(.system(size: 30))
                                                }
                                            }
                                        }
                                    }
                                    .offset(y: 20)
                                    .padding(.top, 30)
                                    Spacer()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Section(header: Text("")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)){
                                    Picker("", selection: self.$editIdentitySex) {
                                        ForEach(0..<Self.sexChoose.count) {
                                            Text("\(Self.sexChoose[$0])")
                                            
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .padding(.top, 30)
                        .padding()
                        
                        Group{
                            VStack(alignment: .leading, spacing: 0) {
                                Text("NATIONALITY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Portugal...", text: self.$editIdentityNationality)
                                    .font(.system(size: 16, weight: .medium))
                                    .autocapitalization(.words)
                                    .padding(.top, 5)
                            }
                            .onAppear {
                                if self.cardID.identityExistImage == 1 {
                                    self.editImage = self.cardID.identityImage!
                                    self.editExistImage = Int(Int16(self.cardID.identityExistImage))
                                }

                                self.editExistImage = Int(Int16(self.cardID.identityExistImage))
                                self.editIdentityNationality = self.cardID.identityNationality ?? ""
                                self.editIdentitylastName = self.cardID.identityLastName ?? ""
                                self.editIdentityName = self.cardID.identityName ?? ""
                                self.editIdentityFiliationMother = self.cardID.identityFiliationMother ?? ""
                                self.editIdentityFiliationFather = self.cardID.identityFiliationFather ?? ""
                                self.editIdentitySex = Int(Int16(self.cardID.identitySex))
                                self.editIdentityHeight = self.cardID.identityHeight ?? ""
                                self.editIdentityDateOfBirth = self.cardID.identityDateOfBirth ?? ""
                                self.editIdentityNumber = self.cardID.identityNumber ?? ""
                                self.editIdentityValid = self.cardID.identityValid ?? ""
                                self.editIdentityMore = self.cardID.identityMore ?? ""
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("LAST NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Last Name", text: self.$editIdentitylastName)
                                    .textContentType(.familyName)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Name", text: self.$editIdentityName)
                                    .textContentType(.name)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0){
                                Text("AFILIATION")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Mother", text: self.$editIdentityFiliationMother)
                                    .font(.system(size: 16, weight: .medium))
                                    .textContentType(.familyName)
                                    .disableAutocorrection(true)
                                    .padding(.top, 5)
                                TextField("Father", text: self.$editIdentityFiliationFather)
                                    .font(.system(size: 16, weight: .medium))
                                    .textContentType(.familyName)
                                    .disableAutocorrection(true)
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("HEIGHT")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Ex: 1.70 m", text: self.$editIdentityHeight)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                        }
                        .padding(.leading)
                        Divider()
                        .opacity(0.5)
                        Group{
                            VStack(alignment: .leading, spacing: 0) {
                                Text("BIRTH")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("MM/YY", text: self.$editIdentityDateOfBirth)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text("ID Nº")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("123...", text: self.$editIdentityNumber)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("EXPIRY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("MM/YY", text: self.$editIdentityValid)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("ADDITIONAL INFORMATION")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("ex: Adress...", text: self.$editIdentityMore)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                                .padding(.bottom)
                        }
                        .padding(.leading)
                    }
                    Spacer()
                }
                .navigationBarTitle("National ID", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.activeEdit = false
                        self.saveEditCardID()
                    }){
                        Text("Save")
                            .foregroundColor(Color("Color5"))
                            .font(.body)
                    }
                    .padding(.vertical)
                )
                    .sheet(isPresented: self.$show, content: {
                        ImagePickerCards(show: self.$show, image: self.$editImage)
                    })
                
            }.autocapitalization(.allCharacters)
        }
    }
    func saveEditCardID() {
        let editCardID = self.cardID
        
       // if self.editImage.count != 0 {
        editCardID.identityExistImage = Int16(self.editExistImage)
        editCardID.identityImage = self.editImage
        editCardID.identityNationality = self.editIdentityNationality
        editCardID.identityLastName = self.editIdentitylastName
        editCardID.identityName = self.editIdentityName
        editCardID.identityFiliationMother = self.editIdentityFiliationMother
        editCardID.identityFiliationFather = self.editIdentityFiliationFather
        editCardID.identitySex = Int16(self.editIdentitySex)
        editCardID.identityHeight = self.editIdentityHeight
        editCardID.identityDateOfBirth = self.editIdentityDateOfBirth
        editCardID.identityNumber = self.editIdentityNumber
        editCardID.identityValid = self.editIdentityValid
        editCardID.identityMore = self.editIdentityMore
            /*

             } else {
                 editCardID.identityExistImage = Int16(self.editExistImage)
                 editCardID.identityImage = self.editImage
                 editCardID.identityNationality = self.editIdentityNationality
                 editCardID.identityLastName = self.editIdentitylastName
                 editCardID.identityName = self.editIdentityName
                 editCardID.identityFiliationMother = self.editIdentityFiliationMother
                 editCardID.identityFiliationFather = self.editIdentityFiliationFather
                 editCardID.identitySex = Int16(self.editIdentitySex)
                 editCardID.identityHeight = self.editIdentityHeight
                 editCardID.identityDateOfBirth = self.editIdentityDateOfBirth
                 editCardID.identityValid = self.editIdentityValid
                 editCardID.identityMore = self.editIdentityMore
             }
             */
        
        try? self.moc.save()
        
    }
}


