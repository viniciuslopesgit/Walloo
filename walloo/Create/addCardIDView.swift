//
//  addCardIDView.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addCardIDView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    static let sexChoose = ["Female", "Male"]
    @State private var show = false
    
    @State private var identitylastName = ""
    @State private var identityName = ""
    @State private var identityFiliationMother = ""
    @State private var identityFiliationFather = ""
    @State private var identitySex = 0
    @State private var identityHeight = ""
    @State private var identityNationality = ""
    @State private var identityDateOfBirth = ""
    @State private var identityNumber = ""
    @State private var identityValid = ""
    @State private var identityMore = ""
    @State var image: Data = .init(count: 0)
    
    let identityNationalitys = ["Brasil", "Portugal", "Alemanha"]
 
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    Group{
                        ZStack{
                            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                            HStack{
                                Spacer()
                                VStack{
                                    if self.image.count != 0 {
                                        Button(action:{
                                            self.show = true
                                        }){
                                            Image(data: self.image, placeholder: "")
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
                                Picker("", selection: $identitySex) {
                                    ForEach(0..<Self.sexChoose.count) {
                                        Text("\(Self.sexChoose[$0])")
                                        
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .padding(.top, 30)
                    .padding()
                    
                    Group{
                        Section {
                            Text("NATIONALITY")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Portugal...", text: $identityNationality)
                                .font(.system(size: 16, weight: .medium))
                                .autocapitalization(.words)
                        }
                        Divider()
                        .opacity(0.5)
                        Section {
                            Text("LAST NAME")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Last Name", text: $identitylastName)
                                .textContentType(.familyName)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("NAME")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Name", text: $identityName)
                                .textContentType(.name)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("AFILIATION")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Mother", text: $identityFiliationMother)
                                .font(.system(size: 16, weight: .medium))
                                .textContentType(.familyName)
                                .disableAutocorrection(true)
                            TextField("Father", text: $identityFiliationFather)
                                .font(.system(size: 16, weight: .medium))
                                .textContentType(.familyName)
                                .disableAutocorrection(true)
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("HEIGHT")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Ex: 1.70 m", text: $identityHeight)
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .padding(.leading)
                    Divider()
                    .opacity(0.5)
                    Group{
                        Section{
                            Text("BIRTH")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("MM/YY", text: $identityDateOfBirth)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            
                            Text("ID Nº")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("123...", text: $identityNumber)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("EXPIRY")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("MM/YY", text: $identityValid)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("ADDITIONAL INFORMATION")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("ex: Address...", text: $identityMore)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                            .padding(.bottom)
                    }
                    .padding(.leading)
                }
                .padding(.bottom, 35)
                
                Spacer()
            }
            .modifier(DisableModalDismiss(disabled: true))
            .sheet(isPresented: self.$show, content: {
                ImagePickerCards(show: self.$show, image: self.$image)
            })
                .navigationBarTitle("New National ID", displayMode: .inline)
                .navigationBarItems(
                        trailing:
                    Button(action: {
                        let newCardID = CardID(context: self.moc)
                                               
                                               if self.image.count != 0 {
                                                   
                                                   newCardID.identityExistImage = 1
                                                   newCardID.identityImage = self.image
                                                   newCardID.identityLastName = self.identitylastName
                                                   newCardID.identityName = self.identityName
                                                   newCardID.identityFiliationMother = self.identityFiliationMother
                                                   newCardID.identityFiliationFather = self.identityFiliationFather
                                                   newCardID.identityNumber = self.identityNumber
                                                   newCardID.identitySex = Int16(self.identitySex)
                                                   newCardID.identityHeight = self.identityHeight
                                                   newCardID.identityNationality = self.identityNationality
                                                   newCardID.identityDateOfBirth = self.identityDateOfBirth
                                                   newCardID.identityValid = self.identityValid
                                                   newCardID.identityMore = self.identityMore
                                               } else {
                                                   newCardID.identityLastName = self.identitylastName
                                                   newCardID.identityName = self.identityName
                                                   newCardID.identityFiliationMother = self.identityFiliationMother
                                                   newCardID.identityFiliationFather = self.identityFiliationFather
                                                   newCardID.identityNumber = self.identityNumber
                                                   newCardID.identitySex = Int16(self.identitySex)
                                                   newCardID.identityHeight = self.identityHeight
                                                   newCardID.identityNationality = self.identityNationality
                                                   newCardID.identityDateOfBirth = self.identityDateOfBirth
                                                   newCardID.identityValid = self.identityValid
                                                   newCardID.identityMore = self.identityMore
                                               }
                                               
                                               try? self.moc.save()
                                               
                                               self.presentationMode.wrappedValue.dismiss()

                    }){
                        Text("Save")
                            .font(.body)
                            .foregroundColor(Color("Color5"))
                    }
            )
        }.autocapitalization(.allCharacters)
    }
}

struct addCardIDView_Previews: PreviewProvider {
    static var previews: some View {
        addCardIDView()
    }
}


