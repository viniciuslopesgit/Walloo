//
//  addDriversLicense.swift
//  iForget
//
//  Created by Vinícius Lopes on 12/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct addDriversLicense: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var driveLicenseName: String = ""
    @State private var driveSectionName: String = ""
    @State private var driveFullName: String = ""
    @State private var driveAddress: String = ""
    @State private var driveBirth: String = ""
    @State private var driveSex: String = ""
    @State private var driveHeight: String = ""
    @State private var driveNumber: String = ""
    @State private var driveLicenceClass: String = ""
    @State private var driveConditionsRestrictions: String = ""
    @State private var driveState: String = ""
    @State private var driveCountry: String = ""
    @State private var driveExpiry: String = ""
    @State private var driveMore: String = ""
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment:.leading){
                    VStack(alignment: .leading){
                        Group{
                            Section{
                                Text("DRIVE LICENSE NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Drive License Name", text: $driveLicenseName)
                                    .textContentType(.organizationName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("SECTION NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Section Name", text: $driveSectionName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("FULL NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Full Name", text: $driveFullName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("ADDRESS")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Address", text: $driveAddress)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                            Section{
                                Text("DATE OF BIRTH")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Date of Birth", text: $driveBirth)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                            .opacity(0.5)
                        }
                    }
                    VStack(alignment: .leading){
                        Section{
                            Text("GENDER")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Gender", text: $driveSex)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("HEIGHT")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("ex: 1.70m", text: $driveHeight)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("NUMBER")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Number", text: $driveNumber)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("LICENSE CLASS")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("License Class", text: $driveLicenceClass)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("CONDITIONS/RESTRICTIONS")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Conditions/Restrictions", text: $driveConditionsRestrictions)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        
                    }
                    VStack(alignment: .leading) {
                        Section{
                            Text("STATE")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("State", text: $driveState)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("COUNTRY")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("Country", text: $driveCountry)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
                        }
                        Divider()
                        .opacity(0.5)
                        Section{
                            Text("EXPIRY DATE")
                                .font(.system(size: 10, weight: .medium))
                                .opacity(0.6)
                            TextField("MM/YY", text: $driveExpiry)
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
                            TextField("Additional Information", text: $driveMore)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .font(.system(size: 16, weight: .medium))
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
            .navigationBarTitle("New Driver's License", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    
                    let newDrive = Drive(context: self.moc)
                    
                    newDrive.driveLicenseName = self.driveLicenseName
                    newDrive.driveSectionName = self.driveSectionName
                    newDrive.driveFullName = self.driveFullName
                    newDrive.driveAddress = self.driveAddress
                    newDrive.driveBirth = self.driveAddress
                    newDrive.driveSex = self.driveSex
                    newDrive.driveHeight = self.driveHeight
                    newDrive.driveNumber = self.driveNumber
                    newDrive.driveLicenseClass = self.driveLicenceClass
                    newDrive.driveConditionsRestrictions = self.driveConditionsRestrictions
                    newDrive.driveState = self.driveState
                    newDrive.driveCountry = self.driveCountry
                    newDrive.driveExpiry = self.driveExpiry
                    newDrive.driveMore = self.driveMore
                    
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

struct addDriversLicense_Previews: PreviewProvider {
    static var previews: some View {
        addDriversLicense()
    }
}
