//
//  EditCard.swift
//  iForget
//
//  Created by Vinícius Lopes on 12/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct EditCard: View {
    
    @Binding var activeEdit: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var editCardName = ""
    @State var editCardNumber = ""
    @State var editCardBrand = 1
    @State var editCardPass = ""
    @State var editCardValid = ""
    @State var editCardPin = ""
    @State var editCardMore = ""
    
    static var cardBrands = ["Visa", "Mastercard", "Amex"]
    
    let card : Card
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment:.leading){
                        VStack(alignment: .leading){
                            Section(header: Text("")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)){
                                    Picker("", selection: self.$editCardBrand) {
                                        ForEach(0..<Self.cardBrands.count) {
                                            Text("\(Self.cardBrands[$0])")
                                            
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .padding()
                        .padding(.bottom)
                        
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                Text("CARDHOLDER NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Name", text: self.$editCardName)
                                    .textContentType(.name)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            .onAppear {
                                self.editCardBrand = Int(Int16(self.card.cardBrand))
                                self.editCardName = self.card.cardName ?? ""
                                self.editCardNumber = self.card.cardNumber ?? ""
                                self.editCardValid = self.card.cardValid ?? ""
                                self.editCardPin = self.card.cardPin ?? ""
                                self.editCardPass = self.card.cardPass ?? ""
                                self.editCardMore = self.card.cardMore ?? ""
                            }
                            Divider()
                            .opacity(0.5)
                                .autocapitalization(.allCharacters)
                            VStack(alignment: .leading, spacing: 0){
                                Text("CARD NUMBER")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                HStack{
                                    Image(systemName: "creditcard.fill")
                                        .font(.system(size: 18, weight: .medium))
                                        .opacity(self.editCardNumber.count > 0 ? 1 : 0.6)
                                    
                                    TextField("XXXX XXXX XXXX XXXX", text: self.$editCardNumber)
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.top, 5)
                                        .padding(.bottom, 3)
                                }
                                .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                                .autocapitalization(.allCharacters)
                            VStack(alignment: .leading, spacing: 0){
                                Text("EXPIRY")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("MM/YY", text: $editCardValid)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                                .autocapitalization(.allCharacters)
                        }
                        .padding(.leading)
                        Group{
                            VStack(alignment: .leading, spacing: 0){
                                Text("CVV")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("CVV", text: self.$editCardPin)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0){
                                Text("PIN")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("PIN", text: self.$editCardPass)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                            VStack(alignment: .leading, spacing: 0){
                                Text("ADDITIONAL INFORMATION")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("ex: Card for...", text: self.$editCardMore)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .truncationMode(.tail)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.top, 5)
                            }
                            Divider()
                            .opacity(0.5)
                        }
                        .padding(.leading)
                    }
                    Spacer()
                }
                .navigationBarTitle("Credit Card", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.activeEdit = false
                        self.saveEditCard()
                    }){
                        Text("Save")
                            .foregroundColor(Color("Color5"))
                            .font(.body)
                        
                    }
                    .padding(.vertical)
                )
            }
        }
    }
    func saveEditCard() {
        let editCard = self.card
        
        editCard.cardBrand = Int16(self.editCardBrand)
        editCard.cardName = self.editCardName
        editCard.cardNumber = self.editCardNumber
        editCard.cardValid = self.editCardValid
        editCard.cardPin = self.editCardPin
        editCard.cardPass = self.editCardPass
        editCard.cardMore = self.editCardMore
        
        try? self.moc.save()
    }
}

