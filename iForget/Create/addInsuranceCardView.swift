//
//  addInsuranceCardView.swift
//  iForget
//
//  Created by Vinícius Lopes on 19/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addInsuranceCardView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var insuranceName: String = ""
    @State private var insuranceGivenNames: String = ""
    @State private var insuranceBirth: String = ""
    @State private var insurancePersonalIdentificationNumber: String = ""
    @State private var insuranceIdentificationNumberInstitution: String = ""
    @State private var insuranceIdentificationCard: String = ""
    @State private var insuranceExpiry: String = ""
    @State private var insuranceMore: String = ""
    

    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment:.leading){
                    Group{
                        Section{
                            Text("LAST NAME")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Last Name", text: $insuranceName)
                            .textContentType(.organizationName)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("NAME")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Name", text: $insuranceGivenNames)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("BIRTH")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Birth", text: $insuranceBirth)
                            .font(.system(size: 16, weight: .medium))
                            .autocapitalization(.allCharacters)
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("PERSONAL IDENTIFICATION Nº")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Personal Identification Nº", text: $insurancePersonalIdentificationNumber)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("NUMBER OF INSTITUTION")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Number of Institution", text: $insuranceIdentificationNumberInstitution)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        }
                        Section{
                            Text("CARD Nº")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("Nº", text: $insuranceIdentificationCard)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("DATA OF EXPIRY")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("DD/MM/YY", text: $insuranceExpiry)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("ADDITIONAL INFORMATION")
                            .font(.system(size: 10, weight: .medium))
                            .opacity(0.6)
                            TextField("ex: Card for...", text: $insuranceMore)
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
            .navigationBarTitle("New Insurance Card", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    
                    let newInsurance = Insurance(context: self.moc)
                    
                    newInsurance.insuranceName = self.insuranceName
                    newInsurance.insuranceGivenNames = self.insuranceGivenNames
                    newInsurance.insuranceBirth = self.insuranceBirth
                    newInsurance.insurancePersonalIdentificationNumber = self.insurancePersonalIdentificationNumber
                    newInsurance.insuranceIdentificationNumberInstitution = self.insuranceIdentificationNumberInstitution
                    newInsurance.insuranceIdentificationCard = self.insuranceIdentificationCard
                    newInsurance.insuranceExpiry = self.insuranceExpiry
                    newInsurance.insuranceMore = self.insuranceMore
                            
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

struct addInsuranceCardView_Previews: PreviewProvider {
    static var previews: some View {
        addInsuranceCardView()
    }
}
