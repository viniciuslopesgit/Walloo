//
//  DetailViewDrive.swift
//  iForget
//
//  Created by Vinícius Lopes on 12/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailViewDrive: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var activeEdit = false
    @State var showCopy = false
    @State var copyName = ""
    @State var showPass = false
    @State var flipped = false
    @State var showingDeleteAlert = false
    
    let driveCard: Drive
    
    var body: some View {
        ZStack{
            DetailDrivePage(showCopy: self.$showCopy, copyName: self.$copyName, showPass: self.$showPass, flipped: self.$flipped, activeEdit: self.$activeEdit, showingDeleteAlert: self.$showingDeleteAlert, driveCard: self.driveCard)
                
                .navigationBarTitle("")
                .navigationBarItems(leading:
                                        Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }){
                                            Text("Done")
                                                .foregroundColor(Color("Color5"))
                                                .font(.body)
                                        },trailing:
                                            HStack{
                                                Button(action:{
                                                    self.showingDeleteAlert = true
                                                }){
                                                    Image(systemName: "trash")
                                                        .foregroundColor(Color("Color5"))
                                                        .font(.body)
                                                }
                                                .padding(.vertical)
                                                .padding(.trailing)
                                                
                                                Button(action: {
                                                    self.activeEdit.toggle()
                                                }){
                                                    Text("Edit")
                                                        .foregroundColor(Color("Color5"))
                                                        .font(.body)
                                                }
                                            }
                )
                .alert(isPresented: $showingDeleteAlert) {
                    Alert(title: Text("Delete Insurance Card"), message: Text("Are you sure?"),
                          primaryButton: .destructive(Text("Delete")){
                            self.deleteCardInsurance()
                          }, secondaryButton: .cancel()
                    )
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    self.activeEdit = false
                }
        }
    }
    func deleteCardInsurance(){
        moc.delete(driveCard)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}


struct DetailDrivePage : View {
    
    @State private var didTap:Bool = false
    @State private var activeAnimation = false
    @State private var isPresent = false
    
    @Binding var showCopy: Bool
    @Binding var copyName: String
    @Binding var showPass: Bool
    @Binding var flipped: Bool
    @Binding var activeEdit: Bool
    @Binding var showingDeleteAlert: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let driveCard: Drive
    
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
                .fixedSize()
            }
            .padding(.bottom)
            .zIndex(1)
            .opacity(showCopy ? 1.0 : 0.0)
            .animation(.spring())
            ScrollView(.vertical, showsIndicators: false){
                ZStack{
                    VStack{
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7861393167, green: 0.7889025522, blue: 0.7971922589, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .frame(height:220)
                            .offset(y: -20)
                            .cornerRadius(14, antialiased: true )
                            .shadow(radius: 4)
                    }
                    .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    .animation(self.activeAnimation ? .spring() : nil)
                    .onTapGesture {
                        self.flipped.toggle()
                    }
                    .padding(.top, -20)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Driver's License | Republic of \(self.driveCard.driveCountry ?? "")")
                                .font(.system(size: 14, weight: .heavy))
                                .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                .opacity(0.7)
                        }
                        .zIndex(11)
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Name")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                    Spacer()
                                }
                                .frame(width: 120)
                                .frame(alignment: .leading)
                                HStack{
                                    Text("\(self.driveCard.driveFullName ?? "")" )
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                                .frame(alignment: .leading)
                            }
                            Spacer()
                        }
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Date of Birth")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                    Spacer()
                                    Text("Gender")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                }
                                HStack{
                                    Text(self.driveCard.driveBirth ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                    Spacer()
                                    Text(self.driveCard.driveSex ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 5)
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Spacer()
                                    Text("License Class")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                }
                                HStack{
                                    Spacer()
                                    Text(self.driveCard.driveLicenseClass ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 5)
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Card Nº")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                    Spacer()
                                    Text("Expiry Date")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                }
                                HStack{
                                    Text(self.driveCard.driveNumber ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                    Spacer()
                                    Text(self.driveCard.driveExpiry ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 5)
                        
                    }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            self.activeAnimation = true
                        }
                    }
                    .opacity(self.flipped ? 0 : 1)
                    .animation(.linear(duration: 0.1))
                    .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    .animation(self.activeAnimation ? .spring() : nil)
                    .padding(.horizontal)
                    
                }
                .padding(.horizontal)
                
                //copy data
                VStack(alignment: .leading){
                    Divider()
                        .padding(.top, 30)
                    Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Drive License Name")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveLicenseName ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = driveCard.driveSectionName
                            self.copyName = "license name"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Section Name")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveSectionName ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = driveCard.driveSectionName
                            self.copyName = "section name"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Full Name")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveFullName ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = driveCard.driveFullName
                            self.copyName = "full name"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Adress")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveAddress ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = self.driveCard.driveAddress
                            self.copyName = "adress"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                    }
                    Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Date of Birth")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveBirth ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = driveCard.driveBirth
                            self.copyName = "Birth"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Gender")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveSex ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            UIPasteboard.general.string = driveCard.driveSex
                            self.copyName = "gender"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Height")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveHeight ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveHeight
                                self.copyName = "height"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                    }
                    Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Number")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveNumber ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveNumber
                                self.copyName = "*****"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("License Class")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveLicenseClass ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveLicenseClass
                                self.copyName = "class"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Conditions/Restrictions")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveConditionsRestrictions ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveConditionsRestrictions
                                self.copyName = "Conditions/Restrictions"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                    }
                    Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("State")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveState ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveState
                                self.copyName = "state"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                        
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Country")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveCountry ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveCountry
                                self.copyName = "country"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Expiry Date")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveExpiry ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveExpiry
                                self.copyName = "expiry date"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                    }
                    Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Additional Information")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(driveCard.driveMore ?? "")
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            
                            if self.showPass == false {
                                self.showPass = true
                            } else if self.showPass == true {
                                UIPasteboard.general.string = driveCard.driveMore
                                self.copyName = "additional information"
                                self.showCopy = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.showCopy = false
                                }
                                self.showPass = false
                            }
                        }
                        Divider()
                            .opacity(0.5)
                            .padding(.bottom, 35)
                    }
                }
                //end copy data
                .sheet(isPresented: $activeEdit, content: {
                    NavigationView{
                        EditDriveCard(activeEdit: self.$activeEdit, driveCard: self.driveCard).environment(\.managedObjectContext, self.moc)
                    }
                })
            }
        }
    }
}
