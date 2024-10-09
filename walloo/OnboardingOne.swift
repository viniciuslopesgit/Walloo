//
//  OnboardingOne.swift
//  iForget
//
//  Created by Vinícius Lopes on 24/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation
import SwiftUI
import StoreKit
import Combine

struct OnboardingOne: View {
    @ObservedObject var userSettings = UserSettings()
    var productRefresh = ProductsStore()
    
    @Environment(\.presentationMode) var presentationMode
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var block : SuccessBlock!
    var product : SKProduct!
    var productsO : ProductsStore?
    
    @State var selectPurchase = 0
    @State var compareProduct = ""
    @State var buying = false
    
    @State private var isDisabled = false
    @State private var shouldAnimate = false
    @State private var textButton = "$1.99/month"
    
    let terms = "Terms of Use"
    let privacy = "Privacy Policy"
    
    @Binding var showUpgradeClose: Bool
    @Binding var goSecondOnboard: Bool
    @Binding var showNews: Bool
    @Binding var showUpgrade : Bool
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                ZStack {
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: self.showUpgradeClose ? 27 : 0))
                                .onTapGesture{
                                    self.showUpgrade.toggle()
                                }
                        }
                        .padding()
                        VStack{
                            HStack{
                                Text("All Your Documents")
                                    .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                    .font(.system(size: 32, weight: .medium))
                            }
                            HStack{
                                Text("One Safe Place")
                                    .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                    .font(.system(size: 32, weight: .medium))
                            }
                        }
                        .padding(.leading)
                        
                        Spacer(minLength: 0)
                        
                        VStack{
                            Spacer()
                            Image("4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250)
                            
                        }
                        .frame(height: 170)
                        
                        Spacer(minLength: 0)
                        
                        if self.userSettings.proBuy {
                            VStack{
                                Text("👏 Congratulations!")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 22, weight: .medium))
                                    .padding(.top, 100)
                                Text("Your account was confirmed. Now you can enjoy all the features of the iForget App.")
                                    .foregroundColor(Color.black)
                                    .opacity(0.5)
                                    .padding(.top, 5)
                                
                                Spacer()
                                HStack{
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                            .frame(height: 47)
                                            .cornerRadius(6)
                                        HStack{
                                            Text("Get started")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                                .onTapGesture {
                                    self.goSecondOnboard.toggle()
                                }
                            }
                            .padding()
                        } else {
                            VStack{
                                HStack{
                                    VStack{
                                        ZStack{
                                            Rectangle()
                                                .foregroundColor(Color.white)
                                                .cornerRadius(9)
                                            
                                            VStack(alignment: .leading){
                                                HStack{
                                                    Text("Monthly")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 16, weight: .bold))
                                                    Spacer(minLength: 0)
                                                }
                                                HStack{
                                                    Text("$1.99/month")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 18, weight: .bold))
                                                    Spacer(minLength: 0)
                                                }
                                                HStack{
                                                    Text("1 month free")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 12))
                                                    Spacer(minLength: 0)
                                                }
                                                .padding(.top, 10)
                                            }
                                            .padding(.leading, 10)
                                        }
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 9).stroke(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)), lineWidth: self.selectPurchase != 1 ? 3 : 1)
                                    )
                                    .frame(height: 90)
                                    .onTapGesture {
                                        self.textButton = "$1.99/month"
                                        withAnimation(.interactiveSpring()){
                                            self.selectPurchase = 0
                                        }
                                    }
                                    
                                    VStack{
                                        ZStack{
                                            Rectangle()
                                                .foregroundColor(Color.white)
                                                .cornerRadius(9)
                                            
                                            VStack(alignment: .leading){
                                                HStack{
                                                    Text("Yearly")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 16, weight: .bold))
                                                    Spacer(minLength: 0)
                                                }
                                                HStack{
                                                    Text("$15.99/year")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 18, weight: .bold))
                                                    Spacer(minLength: 0)
                                                }
                                                HStack{
                                                    Text("Save 33%")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 12))
                                                    Spacer(minLength: 0)
                                                }
                                                .padding(.top, 10)
                                            }
                                            .padding(.leading, 10)
                                        }
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 9).stroke(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)), lineWidth: self.selectPurchase != 0 ? 3 : 1)
                                    )
                                    .frame(height: 90)
                                    .onTapGesture {
                                        self.textButton = "$15.99/year"
                                        withAnimation(.interactiveSpring()){
                                            self.selectPurchase = 1
                                        }
                                    }
                                }
                                .padding(.vertical)
                                
                                HStack{
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                            .frame(height: 47)
                                            .cornerRadius(6)
                                        HStack{
                                            Text("Subscribe \(textButton) ")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color.white)
                                        }
                                        
                                        self.purchaseButtons()
                                            .ignoresSafeArea(.all, edges: .horizontal)
                                        
                                    }
                                }
                                
                                HStack{
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(Color.clear)
                                        
                                        Text("Limited Version")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                            .onTapGesture {
                                                self.goSecondOnboard.toggle()
                                            }
                                    }
                                }
                                .frame(height: 47)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6).stroke(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)), lineWidth: 1)
                                )
                                
                                
                                VStack{
                                        VStack{
                                            Text("After 3 days free this subscription automatically renews for $1.99/monthly until you turn it off. Subscription payments will be charged to your iTunes account at confirmation of you purchasee. You trial or subscription will automatically renew and payment will be charged to your account unless auto-renew is turned off at least 24 hours prior to the end of the current period in your iTunes account settings on the App Store. For more information: ")
                                                .font(.system(size: 10, weight: .medium))
                                                .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                .opacity(0.9)
                                            
                                            HStack{
                                                Button(action: {
                                                    UIApplication.shared.open(URL(string: "https://bit.ly/31TTuBW")!)
                                                }){
                                                    
                                                    HStack(spacing: 3){
                                                        Text("\(terms)")
                                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        Text("&")
                                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        Text("\(privacy)")
                                                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        
                                                    }
                                                    .lineLimit(1)
                                                    .font(.system(size: 10, weight: .medium))
                                                    
                                                    Text("Restore")
                                                        .padding()
                                                        .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                                                        .font(.system(size: 10, weight: .medium))
                                                        .onTapGesture {
                                                            restorePurchases()
                                                        }
                                                }
                                            }
                                            .padding(5)
                                        }
                                }
                                .opacity(0.5)
                            }
                            .padding(.top, 50)
                            .padding(.horizontal)
                        }
                        
                    }
                    .sheet(isPresented: $showNews){
                        News(showNews: $showNews)
                    }
                    VStack{
                        ZStack{
                            Color.black.opacity(0.5)
                                .ignoresSafeArea(.all)
                                .frame(height: UIScreen.main.bounds.height)
                            HStack {
                                /*
                                 Circle()
                                 .fill(Color.white)
                                 .frame(width: 20, height: 20)
                                 .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                                 .animation(Animation.easeInOut(duration: 0.5).repeatForever())
                                 Circle()
                                 .fill(Color.white)
                                 .frame(width: 20, height: 20)
                                 .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                                 .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
                                 Circle()
                                 .fill(Color.white)
                                 .frame(width: 20, height: 20)
                                 .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                                 .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
                                 */
                                
                                Text("Loading...")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.white)
                            }
                            .onAppear {
                                self.shouldAnimate = true
                            }
                        }
                    }
                    .opacity( buying ? 1 : 0)
                    
                }
                .background(Color.pink.opacity(0.3))
                .background(Color.white)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    print("\(self.compareProduct)")
                }
            }
            .navigationBarHidden(true)
            .background(Color.pink.opacity(0.3))
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .all)
        }
        .onAppear{
            /*
             if self.userSettings.proBuy {
             self.goSecondOnboard = true
             }
             */
        }
        
    }
    func purchaseButtons() -> some View {
        // remake to ScrollView if has more than 2 products because they won't fit on screen.
        ZStack{
            Spacer()
            ForEach(ProductsStore.shared.products, id: \.self) { prod in
                HStack{
                    PurchaseButton(block: {
                                    self.purchaseProduct(skproduct: prod)}, product: prod, selectPurchase: $selectPurchase)
                        .disabled(IAPManager.shared.isActive(product: prod))
                        .padding(.top)
                }
            }
            Spacer()
        }
    }
    
    func purchaseProduct(skproduct : SKProduct){
        self.buying = true
        print("did tap purchase product: \(skproduct.productIdentifier)")
        isDisabled = true
        IAPManager.shared.purchaseProduct(product: skproduct, success: {
            print("BUY IS SUCCESS")
            self.buying = false
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
        }) { (error) in
            print("BUY IS FAIL")
            self.buying = false
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
        }
    }
    
    func restorePurchases(){
        self.buying = true
        IAPManager.shared.restorePurchases(success: {
            self.buying = false
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
            
        }) { (error) in
            self.buying = false
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            
        }
    }
}

struct News : View {
    
    @Binding var showNews: Bool
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                
                HStack{
                    Text("Welcome to")
                        .foregroundColor(Color.black)
                        .font(.system(size: 37, weight: .heavy))
                }
                .padding(.top, 30)
                HStack{
                    Text("iForget")
                        .foregroundColor(Color.black)
                        .font(.system(size: 37, weight: .heavy))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.black)
                        Text("Take your documents anywhere")
                            .foregroundColor(Color.black)
                            .font(.headline)
                    }
                    HStack{
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.black)
                        Text("Save your documents on your phone and iCloud will sync them across all your devices")
                            .foregroundColor(Color.black)
                            .font(.headline)
                    }
                    HStack{
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.black)
                        Text("Mark files as favorites and access them quickly")
                            .foregroundColor(Color.black)
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(#colorLiteral(red: 0.1294117647, green: 0.09411764706, blue: 0.3882352941, alpha: 1)))
                            .frame(height: 47)
                            .cornerRadius(6)
                        
                        Text("Continue")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding()
                    }
                }
                .padding()
                .onTapGesture {
                    self.showNews.toggle()
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}
