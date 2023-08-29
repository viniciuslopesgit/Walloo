//
//  EditDriveCard.swift
//  iForget
//
//  Created by Vinícius Lopes on 13/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI

struct EditDriveCard: View {
    
    @Binding var activeEdit: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editDriveLicenseName: String = ""
    @State private var editDriveSectionName: String = ""
    @State private var editDriveFullName: String = ""
    @State private var editDriveAddress: String = ""
    @State private var editDriveBirth: String = ""
    @State private var editDriveSex: String = ""
    @State private var editDriveHeight: String = ""
    @State private var editDriveNumber: String = ""
    @State private var editDriveLicenceClass: String = ""
    @State private var editDriveConditionsRestrictions: String = ""
    @State private var editDriveState: String = ""
    @State private var editDriveCountry: String = ""
    @State private var editDriveExpiry: String = ""
    @State private var editDriveMore: String = ""
    
    let driveCard: Drive
    
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
                                TextField("Drive License Name", text: self.$editDriveLicenseName)
                                    .textContentType(.organizationName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .onAppear {
                                self.editDriveLicenseName = self.driveCard.driveLicenseName ?? ""
                                self.editDriveFullName = self.driveCard.driveFullName ?? ""
                                self.editDriveSectionName = self.driveCard.driveSectionName ?? ""
                                self.editDriveAddress = self.driveCard.driveAddress ?? ""
                                self.editDriveBirth = self.driveCard.driveBirth ?? ""
                                self.editDriveSex = self.driveCard.driveSex ?? ""
                                self.editDriveHeight = self.driveCard.driveHeight ?? ""
                                self.editDriveNumber = self.driveCard.driveNumber ?? ""
                                self.editDriveLicenceClass = self.driveCard.driveLicenseClass ?? ""
                                self.editDriveConditionsRestrictions = self.driveCard.driveConditionsRestrictions ?? ""
                                self.editDriveState = self.driveCard.driveState ?? ""
                                self.editDriveCountry = self.driveCard.driveCountry ?? ""
                                self.editDriveExpiry = self.driveCard.driveExpiry ?? ""
                                self.editDriveMore = self.driveCard.driveMore ?? ""
                            }
                            Divider()
                                .opacity(0.5)
                            Section{
                                Text("SECTION NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Section Name", text: self.$editDriveSectionName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                                .opacity(0.5)
                            Section{
                                Text("FULL NAME")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Full Name", text: self.$editDriveFullName)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                                .opacity(0.5)
                            Section{
                                Text("ADRESS")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Adress", text: self.$editDriveAddress)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            Divider()
                                .opacity(0.5)
                            Section{
                                Text("DATE OF BIRTH")
                                    .font(.system(size: 10, weight: .medium))
                                    .opacity(0.6)
                                TextField("Date of Birth", text: self.$editDriveBirth)
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
                            TextField("Gender", text: self.$editDriveSex)
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
                            TextField("ex: 1.70m", text: self.$editDriveHeight)
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
                            TextField("Number", text: self.$editDriveNumber)
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
                            TextField("License Class", text: self.$editDriveLicenceClass)
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
                            TextField("Conditions/Restrictions", text: self.$editDriveConditionsRestrictions)
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
                            TextField("State", text: self.$editDriveState)
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
                            TextField("Country", text: self.$editDriveCountry)
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
                            TextField("MM/YY", text: self.$editDriveExpiry)
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
                            TextField("Addittional Information", text: self.$editDriveMore)
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
            .navigationBarTitle("Driver's License", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.activeEdit = false
                                        self.saveEditDrive()
                                    }){
                                        Text("Save")
                                            .foregroundColor(Color("Color5"))
                                            .font(.body)
                                    }
                .padding(.vertical)
            )
        }
    }
    func saveEditDrive() {
        let editDrive = self.driveCard
        
        editDrive.driveLicenseName = self.editDriveLicenseName
        editDrive.driveSectionName = self.editDriveSectionName
        editDrive.driveFullName = self.editDriveFullName
        editDrive.driveAddress = self.editDriveAddress
        editDrive.driveBirth = self.editDriveBirth
        editDrive.driveSex = self.editDriveSex
        editDrive.driveHeight = self.editDriveHeight
        editDrive.driveNumber = self.editDriveNumber
        editDrive.driveLicenseClass = self.editDriveLicenceClass
        editDrive.driveConditionsRestrictions = self.editDriveConditionsRestrictions
        editDrive.driveState = self.editDriveState
        editDrive.driveCountry = self.editDriveCountry
        editDrive.driveExpiry = self.editDriveExpiry
        editDrive.driveMore = self.editDriveMore
        
        
        try? self.moc.save()
    }
}


