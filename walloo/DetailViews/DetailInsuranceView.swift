//
//  DetailInsuranceView.swift
//  iForget
//
//  Created by Vinícius Lopes on 20/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//
import CoreData
import SwiftUI

struct DetailInsuranceView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    @State private var didTap:Bool = false
    @State private var activeAnimation = false
    
    @State var showCopy: Bool = false
    @State var copyName: String = ""
    @State var showPass: Bool = false
    @State var flipped: Bool = false
    @State var activeEdit: Bool = false
    
    let insurance: Insurance
    
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
            VStack{
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
                    
                    VStack{
                        Divider()
                            .padding(.top, 30)
                        //copy data
                        VStack(alignment: .leading){
                            Group{
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Last Name")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceName ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .onTapGesture {
                                    UIPasteboard.general.string = self.insurance.insuranceName
                                    self.copyName = "Last Name"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Name")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceGivenNames ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .onTapGesture {
                                    UIPasteboard.general.string = self.insurance.insuranceGivenNames
                                    self.copyName = "Name"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Birth")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceBirth ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .onTapGesture {
                                    UIPasteboard.general.string = self.insurance.insuranceBirth
                                    self.copyName = "Birth"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                            }
                            Group{
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Personal Identification Nº")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insurancePersonalIdentificationNumber ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .onTapGesture {
                                    UIPasteboard.general.string = self.insurance.insurancePersonalIdentificationNumber
                                    self.copyName = "Personal ID"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Number Of Institution")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceIdentificationNumberInstitution ?? "")
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
                                        UIPasteboard.general.string = self.insurance.insuranceIdentificationNumberInstitution
                                        self.copyName = "Institution Nº *****"
                                        self.showCopy = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.showCopy = false
                                        }
                                        self.showPass = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                            }
                            Group{
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Card Nº")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceIdentificationCard ?? "")
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
                                        UIPasteboard.general.string = self.insurance.insuranceIdentificationCard
                                        self.copyName = "Card Nº *****"
                                        self.showCopy = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.showCopy = false
                                        }
                                        self.showPass = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Data of Expiry")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceExpiry ?? "")
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
                                        UIPasteboard.general.string = self.insurance.insuranceExpiry
                                        self.copyName = "Expiry"
                                        self.showCopy = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.showCopy = false
                                        }
                                        self.showPass = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Additional Information")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.insurance.insuranceMore ?? "")
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
                                        UIPasteboard.general.string = self.insurance.insuranceMore
                                        self.copyName = "Additional Information"
                                        self.showCopy = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.showCopy = false
                                        }
                                        self.showPass = false
                                    }
                                }
                                Divider()
                                    .padding(.bottom, 35)
                            }
                        }
                        
                    }
                    //end copy data
                }
                
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
        moc.delete(insurance)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailInsuranceView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let insurance = Insurance(context: moc)
        insurance.insuranceName = ""
        
        return NavigationView{
            DetailInsuranceView(insurance: insurance)
        }.edgesIgnoringSafeArea(.top)
    }
}
