//
//  DetailView.swift
//  iForget
//
//  Created by Vinícius Lopes on 22/06/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingDeleteAlert = false
    @State private var didTap:Bool = false
    
    @State var showCopy: Bool = false
    @State var copyName: String = ""
    @State var showPass: Bool = false
    @State var flipped: Bool = false
    
    @State var activeEdit: Bool = false
    
    @ObservedObject var card: Card
    
    @State private var activeAnimation = false
    
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
                    ZStack(alignment: .bottomTrailing) {
                        VStack{
                            if self.card.cardBrand == 0 {
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    .frame(height:220)
                                    .cornerRadius(14, antialiased: true)
                            }
                            if self.card.cardBrand == 1 {
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    .frame(height:220)
                                    .cornerRadius(14, antialiased: true)
                            }
                            if self.card.cardBrand == 2 {
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    .frame(height:220)
                                    .cornerRadius(14, antialiased: true)
                            }
                        }
                        .onTapGesture {
                            self.flipped.toggle()
                        }
                        .padding(.horizontal)
                        .padding(.top, -20)
                        
                        HStack{
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
                                        .opacity(0.80)
                                    
                                    Circle()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 38)
                                        .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                                        .offset(x: -25)
                                        .opacity(0.80)
                                } else if card.cardBrand == 2{
                                    Text("AMEX")
                                        .foregroundColor(.white)
                                        .font(.system(size: 21, weight: .heavy))
                                }
                            }
                            .padding(.trailing, 30)
                        }
                        .opacity(self.flipped ? 0 : 1)
                        .animation(.linear(duration: 0.1))
                        .offset(y: -155)
                        
                        HStack{
                            Spacer()
                            Text(flipped ? self.card.cardPin ?? "" : self.card.cardNumber ?? "" )
                                .foregroundColor(self.flipped ? Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1)) : Color(#colorLiteral(red: 0.9553656409, green: 0.9553656409, blue: 0.9553656409, alpha: 1)))
                                .font(.system(size: self.flipped ? 18 : 23, weight: .semibold))
                                .lineLimit(1)
                                .offset(x: self.flipped ? 70 : 0, y: -90)
                                .animation(.spring(response: 0.4, dampingFraction: 1, blendDuration: 0.4))
                            Spacer()
                        }
                        .zIndex(self.flipped ? 1 : 0)
                        .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                        .animation(.linear(duration: 0.2))
                        ZStack{
                            HStack{
                                Color(#colorLiteral(red: 0.07753013959, green: 0.07753013959, blue: 0.07753013959, alpha: 1))
                            }
                            HStack{
                                Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                    .opacity(0.7)
                            }
                            .offset(y: 60)
                            .padding(.horizontal)
                        }
                        .offset(y: -150)
                        .padding(.horizontal)
                        .frame(height: 47)
                        .opacity(self.flipped ? 1 : 0)
                        .animation(.linear(duration: 0.1))
                        
                        HStack{
                            
                            VStack(alignment: .leading){
                                Text(self.card.cardName ?? "")
                                    .foregroundColor(Color(#colorLiteral(red: 0.9553656409, green: 0.9553656409, blue: 0.9553656409, alpha: 1)))
                                    .font(.system(size: 14, weight: .semibold))
                                    .lineLimit(1)
                                    .frame(minWidth: 0, maxWidth: 270)
                            }
                            .opacity(self.flipped ? 0 : 1)
                            .animation(.linear(duration: 0.1))
                            .padding(.leading, 20)
                            VStack{
                                Text("VALID")
                                Text("THRUE")
                            }
                            .foregroundColor(Color(#colorLiteral(red: 0.8785691624, green: 0.8785691624, blue: 0.8785691624, alpha: 1)))
                            .font(.system(size: 5, weight: .semibold))
                            
                            Text(self.card.cardValid ?? "")
                                .foregroundColor(Color(#colorLiteral(red: 0.9553656409, green: 0.9553656409, blue: 0.9553656409, alpha: 1)))
                                .font(.system(size: 14, weight: .semibold))
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 20)
                            
                            Spacer()
                        }
                        .opacity(self.flipped ? 0 : 1)
                        .animation(.linear(duration: 0.1))
                        .padding()
                        .offset(y: -30)
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        self.activeAnimation = true
                    }
                }
                .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                .animation(activeAnimation ? .spring() : nil)
                //menu
                VStack{
                    Divider()
                        .padding(.top, 30)
                    //Data for copy
                        VStack(alignment: .leading){
                            Group{
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Name")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        Text(self.card.cardName ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    UIPasteboard.general.string = self.card.cardName
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
                                        Text("Number")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        Text(self.card.cardNumber ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    UIPasteboard.general.string = self.card.cardNumber
                                    self.copyName = "Number"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("Expiry")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        
                                        Text(self.card.cardValid ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    UIPasteboard.general.string = self.card.cardValid
                                    self.copyName = "Valid"
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
                                        Text("CSV")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        Text(self.card.cardPin ?? "" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .background(Color("Color1"))
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    UIPasteboard.general.string = self.card.cardPin
                                    self.copyName = "PIN"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        self.showCopy = false
                                    }
                                }
                                Divider()
                                    .padding(.leading)
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Text("PIN")
                                            .foregroundColor(Color("Color4"))
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.leading)
                                        Text(showPass == true ? self.card.cardPass ?? "" : "*****" )
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    
                                    if self.showPass == false {
                                        self.showPass = true
                                    } else if self.showPass == true {
                                        UIPasteboard.general.string = self.card.cardPass
                                        self.copyName = "*****"
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
                                        Text(self.card.cardMore ?? "")
                                            .font(.system(size: 16))
                                            .padding(.leading)
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                }
                                .background(Color("Color1").opacity(0.0001))
                                .onTapGesture {
                                    UIPasteboard.general.string = self.card.cardMore
                                    self.copyName = "***"
                                    self.showCopy = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.showCopy = false
                                    }
                                }
                            }
                            Divider()
                            .padding(.bottom, 35)
                        }
                    }
                }
        }
        .sheet(isPresented: self.$activeEdit) {
            EditCard(activeEdit: self.$activeEdit, card: self.card).environment(\.managedObjectContext, self.moc)
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
                        self.deleteCard()
                    }, secondaryButton: .cancel()
                )
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.activeEdit = false
        }
    }
    func deleteCard(){
        moc.delete(card)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}


struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext( concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let card = Card(context: moc)
        card.cardBrand = 1
        card.cardName = "VINICIUS LOPES DE SOUZA SOUZA"
        card.cardNumber = "0000 0000 0000 0000"
        card.cardValid = "09/09"
        card.cardPin = "353"
        card.cardPass = "123"
        
        return NavigationView{
            DetailView(card: card)
        }.edgesIgnoringSafeArea(.top)
        
    }
}

