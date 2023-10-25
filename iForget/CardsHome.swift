//
//  CardsHome.swift
//  iForget
//
//  Created by Vinícius Lopes on 14/08/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import SwiftUI

struct CreditCard: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var isPresent = false
    
    let card: Card
    
    var body: some View {
        
        ZStack{
            VStack{
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(height:220)
                        .offset(y: -20)
                        .cornerRadius(14, antialiased: true )
                        .padding(.leading)
                        .padding(.trailing)
                        .shadow(radius: 4)
                    HStack{
                        Text(card.cardNumber ?? "")
                            .foregroundColor(Color(#colorLiteral(red: 0.9553656409, green: 0.9553656409, blue: 0.9553656409, alpha: 1)))
                            .font(.system(size: 21, weight: .semibold))
                            .lineLimit(1)
                            .truncationMode(.head)
                            .frame(maxWidth: 80)
                            .padding(.leading)
                        Spacer()
                        Text(card.cardValid ?? "")
                            .foregroundColor(Color(#colorLiteral(red: 0.9553656409, green: 0.9553656409, blue: 0.9553656409, alpha: 1)))
                            .font(.system(size: 21, weight: .semibold))
                            .truncationMode(.head)
                        Spacer()
                        
                        VStack{
                            ZStack{
                                if card.cardBrand == 0{
                                    Text("VISA")
                                        .foregroundColor(.white)
                                        .font(.system(size: 21, weight: .heavy))
                                } else if card.cardBrand == 1{
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                        .opacity(0.85)
                                    
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                                        .offset(x: -28)
                                        .opacity(0.85)
                                } else if card.cardBrand == 2{
                                    Text("AMEX")
                                        .foregroundColor(.white)
                                        .font(.system(size: 21, weight: .heavy))
                                }
                            }
                            .padding(.trailing)
                        }
                    }
                    .padding()
                    .offset(y: -65)
                }
            }
        }
        .onTapGesture {
            self.isPresent.toggle()
        }
         .sheet(isPresented: $isPresent, content: {
             NavigationView{
                 DetailView( card: self.card).environment(\.managedObjectContext, self.moc)
             }
         })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isPresent = false
        }
    }
}

struct IdentityCard: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State private var placeholder = "Loading"
    @State private var imageS = "iforget"
    @State var isPresent: Bool = false
    let cardID: CardID
    
    var body: some View {
        
        ZStack{
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
                            Text("Republic of \(self.cardID.identityNationality ?? "")")
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
        .onTapGesture {
            self.isPresent.toggle()
        }
        .sheet(isPresented: $isPresent, content: {
            NavigationView{
                DetailViewCardID( cardID: self.cardID).environment(\.managedObjectContext, self.moc)
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isPresent = false
        }
    }
}

struct InsuranceCard: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var isPresent: Bool = false
    
    let insurance: Insurance
    
    var body: some View {
        
        ZStack{
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
                            Image(systemName: "waveform.path.ecg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(.red)
                            Spacer()
                            Text("Insurance Card")
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
                                    Text("\(insurance.insuranceGivenNames ?? "") \(insurance.insuranceName ?? "")" )
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
                                    Text("Personal Identification Number")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                }
                                HStack{
                                    Text(insurance.insuranceBirth ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                    Spacer()
                                    Text(insurance.insurancePersonalIdentificationNumber ?? "")
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
                                    Text("Number of Institution")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                        .opacity(0.7)
                                }
                                HStack{
                                    Spacer()
                                    Text(insurance.insuranceIdentificationNumberInstitution ?? "")
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
                                    Text(insurance.insuranceIdentificationCard ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                    Spacer()
                                    Text(insurance.insuranceExpiry ?? "")
                                        .lineLimit(1)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(#colorLiteral(red: 0.152164878, green: 0.1647522386, blue: 0.183038547, alpha: 1)))
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 5)
                        
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
            }
        }
        .onTapGesture {
            self.isPresent.toggle()
        }
        .sheet(isPresented: $isPresent, content: {
            NavigationView{
                DetailInsuranceView( insurance: self.insurance).environment(\.managedObjectContext, self.moc)
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isPresent = false
        }
    }
}

struct DriveLicence: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var isPresent: Bool = false
    
    let driveCard: Drive
    
    var body: some View {
        
        ZStack{
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
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
            }
        }
        .onTapGesture {
            self.isPresent.toggle()
        }
        .sheet(isPresented: $isPresent, content: {
            NavigationView{
               DetailViewDrive(driveCard: self.driveCard).environment(\.managedObjectContext, self.moc)
            }
        })
         .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
             self.isPresent = false
         }
         
    }
}

struct PassportCard: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    
    @State var isPresent = false
    
    let passport: Passport
    
    var body: some View {
        
        ZStack{
            VStack{
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3509699702, green: 0.08615193516, blue: 0.1727219522, alpha: 1)), Color(#colorLiteral(red: 0.5289587379, green: 0.1315039992, blue: 0.3047688007, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .frame(height:420)
                        .cornerRadius(14, antialiased: true )
                        .padding(.leading)
                        .padding(.trailing)
                        .shadow(radius: 4)
                    
                    VStack{
                        HStack{
                            Text("PASSPORT")
                                .foregroundColor(Color(#colorLiteral(red: 0.898837626, green: 0.8200288415, blue: 0.5507953167, alpha: 1)))
                                .font(.system(size: 27, weight: .bold))
                                .shadow(radius: 2)
                        }
                        .padding(.top)
                        Spacer()
                        Image(systemName: "globe")
                            .font(.system(size:120, weight: .thin))
                            .foregroundColor(Color(#colorLiteral(red: 0.898837626, green: 0.8200288415, blue: 0.5507953167, alpha: 1)))
                            .shadow(radius: 2)
                        
                        Spacer()
                    }
                }
            }
        }
        .onTapGesture {
            self.isPresent.toggle()
        }
        .sheet(isPresented: $isPresent, content: {
            NavigationView{
                DetailPassportView(passport: self.passport).environment(\.managedObjectContext, self.moc)
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isPresent = false
        }
    }
}
