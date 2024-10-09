//
//  addCardView.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addCardView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cardName = ""
    @State private var cardNumber = ""
    @State private var cardBrand = 1
    @State private var cardPass = ""
    @State private var cardValid = ""
    @State private var cardPin = ""
    @State private var cardMore = ""
    
    static var cardBrands = ["Visa", "Mastercard", "Amex"]
    
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment:.leading){
                    VStack(alignment: .leading){
                        Section(header: Text("")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)){
                            Picker("", selection: $cardBrand) {
                                ForEach(0..<Self.cardBrands.count) {
                                    Text("\(Self.cardBrands[$0])")
                                    
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .padding()
                    .padding(.bottom)
                    
                    Group{
                        Section{
                            Text("CARDHOLDER NAME")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Name", text: $cardName)
                                .textContentType(.name)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                            .opacity(0.5)
                            .autocapitalization(.allCharacters)
                        Section{
                            Text("CARD NUMBER")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            HStack{
                                Image(systemName: "creditcard.fill")
                                
                                TextField("XXXX XXXX XXXX XXXX", text: $cardNumber)
                                    .textContentType(.creditCardNumber)
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .autocapitalization(.allCharacters)
                        Section{
                            Text("EXPIRY")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("MM/YY", text: $cardValid)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                            .opacity(0.5)
                            .autocapitalization(.allCharacters)
                    }
                    .padding(.leading)
                    Group{
                        Section{
                            Text("CVV")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("CVV", text: $cardPin)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                            .opacity(0.5)
                        Section{
                            Text("PIN")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("PIN", text: $cardPass)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                            .opacity(0.5)
                        Section{
                            Text("ADDITIONAL INFORMATION")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("ex: Card for...", text: $cardMore)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .truncationMode(.tail)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                            .opacity(0.5)
                    }
                    .padding(.leading)
                }
                .padding(.bottom, 35)
                
                Spacer()
            }
            .modifier(DisableModalDismiss(disabled: true))
            .navigationBarTitle("New Credit Card", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        let newCard = Card(context: self.moc)
                        
                        newCard.cardName = self.cardName
                        newCard.cardNumber = self.cardNumber
                        newCard.cardValid = self.cardValid
                        newCard.cardPin = self.cardPin
                        newCard.cardBrand = Int16(self.cardBrand)
                        newCard.cardPass = self.cardPass
                        newCard.cardMore = self.cardMore
                        
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

struct addCardView_Previews: PreviewProvider {
    static var previews: some View {
        addCardView()
    }
}

