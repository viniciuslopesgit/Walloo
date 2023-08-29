//
//  DetailViewCardID.swift
//  iForget
//
//  Created by Vinícius Lopes on 23/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailViewCardID: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    @State private var didTap:Bool = false
    @State var showCopy: Bool = false
    @State var copyName: String = ""
    
    @State private var nameSex = ""
    
    @State var activeEdit: Bool = false
    
    let cardID: CardID
    
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
            }
            .padding(.bottom)
            .zIndex(1)
            .opacity(showCopy ? 1.0 : 0.0)
            .animation(.spring())

            
            ScrollView(.vertical, showsIndicators: false){
            VStack{
                CardID_Card(cardID: cardID)
                    .padding(.top, -20)
                Spacer()
                Divider()
                    .padding(.top, 30)
                    Group{
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Nationality")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityNationality ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Nationality"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityNationality
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Last Name")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityLastName ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Last Name"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityLastName
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            HStack{
                                Text("Name")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityName ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Name"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityName
                        }
                        Divider()
                            .padding(.leading)
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Mother")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityFiliationMother ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Mother"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityFiliationMother
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Father")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityFiliationFather ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Father"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityFiliationFather
                        }
                        Divider()
                            .padding(.leading)
                    }
                    Group{
                        VStack(alignment: .leading, spacing: 0){
                            
                            HStack{
                                Text("Gender")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                if self.cardID.identitySex == 0 {
                                    Text("Female" )
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                } else if self.cardID.identitySex == 1 {
                                    Text("Male")
                                        .font(.system(size: 16))
                                        .padding(.leading)
                                    
                                }
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Gender"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            if self.cardID.identitySex == 0 {
                                self.nameSex = "Female"
                                UIPasteboard.general.string = self.nameSex
                            } else if self.cardID.identitySex == 1 {
                                self.nameSex = "Male"
                                UIPasteboard.general.string = self.nameSex
                            }
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            
                            HStack{
                                Text("Height")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityHeight ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Height"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityHeight
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Birth")
                                    .foregroundColor(Color("Color4"))
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.leading)
                                
                                Text(self.cardID.identityDateOfBirth ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Birth"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityDateOfBirth
                        }
                        Divider()
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                
                                    Text("Number")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                
                                Text(self.cardID.identityNumber ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Nº"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityNumber
                        }
                        Divider()
                        .opacity(0.5)
                            .padding(.leading)
                }
                Group{
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                
                                    Text("Expiry")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                
                                Text(self.cardID.identityValid ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Expiry"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityValid
                        }
                        Divider()
                        .opacity(0.5)
                            .padding(.leading)
                        
                    VStack(alignment: .leading, spacing: 0){
                            HStack{
                                
                                    Text("Additional Information")
                                        .foregroundColor(Color("Color4"))
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.leading)
                                
                                Text(self.cardID.identityMore ?? "" )
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                Spacer()
                            }
                            .background(Color("Color1"))
                            .padding(.top, 5)
                        }
                        .onTapGesture {
                            self.copyName = "Additional Information"
                            self.showCopy = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showCopy = false
                            }
                            UIPasteboard.general.string = self.cardID.identityMore
                        }
                        Divider()
                        .opacity(0.5)
                        .padding(.bottom, 35)
                    }
                }
            }
        }
        .sheet(isPresented: self.$activeEdit) {
            EditCardID(activeEdit: self.$activeEdit, cardID: self.cardID).environment(\.managedObjectContext, self.moc)
        }
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
                
                Button(action:{
                    self.activeEdit = true
                }){
                    Text("Edit")
                        .foregroundColor(Color("Color5"))
                        .font(.body)
                }
                .padding(.vertical)
                /*
                 Button(action:{
                 }){
                 Image(systemName: "square.and.arrow.up")
                 .foregroundColor(Color(#colorLiteral(red: 0.02352941176, green: 0.1921568627, blue: 0.7450980392, alpha: 1)))
                 }
                 */
            }
        )
            .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Delete card"), message: Text("Are you sure?"),
                      primaryButton: .destructive(Text("Delete")){
                        self.deleteCardID()
                    }, secondaryButton: .cancel()
                )
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.activeEdit = false
        }
        
    }
    func deleteCardID(){
        moc.delete(cardID)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailViewCardID_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let cardID = CardID(context: moc)
        cardID.identityName = "Test card"
        cardID.identityLastName = "0000 0000 0000 0000"
        cardID.identityNationality = "Mastercard"
        
        return NavigationView{
            DetailViewCardID(cardID: cardID)
        }.edgesIgnoringSafeArea(.top)
        
    }
}


struct CardID_Card: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var image: Image?
    let cardID: CardID
    var body: some View {
        VStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7861393167, green: 0.7889025522, blue: 0.7971922589, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .frame(height:220)
                    .offset(y: -20)
                    .cornerRadius(14, antialiased: true )
                    .padding(.leading)
                    .padding(.trailing)
                    .shadow(radius: 4)
                VStack{
                    HStack{
                        Spacer()
                        Text("Republic of \(cardID.identityNationality ?? "")")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                            .opacity(0.7)
                        Spacer()
                        Text("ID")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                            .opacity(0.7)
                    }
                    HStack{
                        VStack{
                            Image(data: self.cardID.identityImage, placeholder: "")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 100)
                                .cornerRadius(5)
                                .padding(.bottom, 5)
                                .shadow(radius: 0.3)
                        }
                        ZStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Last Name")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .offset(x: -30)
                                        .opacity(0.7)
                                }
                                .frame(width: 120)
                                .frame(alignment: .leading)
                                HStack{
                                    Text(cardID.identityLastName ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                                .frame(alignment: .leading)
                            }
                            Spacer()
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Name")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .offset(x: -30)
                                        .opacity(0.7)
                                    
                                    Text("Sex")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .offset(x: 40)
                                        .opacity(0.7)
                                }
                                .frame(width: 120)
                                .frame(alignment: .leading)
                                HStack{
                                    Text(cardID.identityName ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                    
                                    if self.cardID.identitySex == 0 {
                                        Text("Female")
                                            .lineLimit(1)
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                            .offset(x: 40)
                                        
                                    } else if self.cardID.identitySex == 1 {
                                        Text("Male")
                                            .lineLimit(1)
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                            .offset(x: 40)
                                    }
                                }
                                .frame(alignment: .leading)
                            }.offset(y: 40)
                        }
                        Spacer()
                    }
                    HStack{
                        Text("Nº ID")
                            .font(.system(size: 9, weight: .medium, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                            .opacity(0.7)
                        Spacer()
                        Text("Date of Birth")
                            .font(.system(size: 9, weight: .medium, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                            .opacity(0.7)
                    }
                    .padding(.top)
                    HStack{
                        Text(cardID.identityNumber ?? "")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                        Spacer()
                        Text(cardID.identityDateOfBirth ?? "")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 30)
            }
        }
    }
}
