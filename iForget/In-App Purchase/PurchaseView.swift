

import Foundation
import SwiftUI
import StoreKit
import Combine

struct PurchaseView : View {
    
    @Environment(\.presentationMode) var presentationMode
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    @State private var isDisabled : Bool = false
    @State var selectPurchase = 0
    
    var body: some View {
        
        NavigationView{
            ScrollView (showsIndicators: false) {
                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(Color("Color7"))
                            .frame(width: 75, height: 75)
                            .offset(y: -210)
                            .zIndex(10)
                        VStack(spacing: 0){
                            Image("iForgetLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .zIndex(1.0)
                        }
                        .offset(y: -210)
                        .zIndex(10)
                        VStack(spacing: 0){
                        self.aboutText()
                            .padding(.top)
                        VStack(spacing: 0){
                           
                            self.purchaseButtons()
                        }
                    }
                    .frame(minWidth: 310, minHeight: 450)
                    .background(Color("Color7"))
                    .cornerRadius(5)
                    .padding()
                    .padding(.top, 35)
                    .shadow(color: .primary, radius: 0.5)
                    }
                    self.helperButtons()
                    .foregroundColor(Color("Color5"))
                }
                .navigationBarTitle("iForget Premium", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        Text("Close")
                    }){
                        self.dismissButton()
                    }
                    
                )
            }.disabled(self.isDisabled)
        }
    }
    
    // MARK:- View creations
    
    func purchaseButtons() -> some View {
        // remake to ScrollView if has more than 2 products because they won't fit on screen.
        VStack {
            Spacer()
            ForEach(ProductsStore.shared.products, id: \.self) { prod in
                VStack{
                    PurchaseButton(block: {
                                    self.purchaseProduct(skproduct: prod)}, product: prod, selectPurchase: $selectPurchase)
                        .disabled(IAPManager.shared.isActive(product: prod))
                        .padding(.top)
                }
            }
            Spacer()
        }
    }
    
    func helperButtons() -> some View{
        HStack {
            Button(action: { 
                self.termsTapped()
            }) {
                Text("Terms of use").font(.footnote)
            }
            Button(action: { 
                self.privacyTapped()
            }) {
                Text("Privacy policy").font(.footnote)
            }
            Button(action: {
                self.restorePurchases()
            }) {
                Text("Restore purchases").font(.footnote)
            }
        }.padding()
    }
    
    func aboutText() -> some View {
        VStack(alignment: .center){
            ScrollView(.vertical, showsIndicators: true){
                VStack(alignment: .leading) {
                    HStack{
                        VStack{
                            Text("""
                            The free version of iForget allows you to import, create or scan a limited set of documents.
                            """)
                        }
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(nil)
                    }
                    HStack{
                        Text("Premium features:")
                        .font(.system(size: 14, weight: .medium))
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Color5"))
                            .font(.system(size: 14))
                            .font(.system(size: 14))
                        Text("Create unlimited files")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Color5"))
                            .font(.system(size: 14))
                            .font(.system(size: 14))
                        Text("Completely Ad Free Experience")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Color5"))
                            .font(.system(size: 14))
                            .font(.system(size: 14))
                        Text("Scan documents and import photos")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Color5"))
                            .font(.system(size: 14))
                            .font(.system(size: 14))
                        Text("Access your documents from anywhere")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color("Color5"))
                            .font(.system(size: 14))
                            .font(.system(size: 14))
                        Text("Sync with all your devices")
                            .font(.system(size: 14, weight: .medium))
                            .lineLimit(1)
                    }
                    
                    
                }
                .padding()
                .padding(.top, 35)
            }
        }
        .font(.system(size: 10, weight: .medium))
        .opacity(0.8)
    }
    
    
    func dismissButton() -> some View {
        Button(action: { 
            self.dismiss()
        }) {
            Text("Not now")
            .foregroundColor(Color("Color5"))
        }.padding(.vertical)
    }
    
    //MARK:- Actions
    
    func restorePurchases(){
        
        IAPManager.shared.restorePurchases(success: { 
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
            
        }) { (error) in
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            
        }
    }
    
    func termsTapped(){

        UIApplication.shared.open(URL(string: "https://bit.ly/31TTuBW")!)
    }
    
    func privacyTapped(){

        UIApplication.shared.open(URL(string: "https://bit.ly/31TTuBW")!)
    }
    
    func purchaseProduct(skproduct : SKProduct){
        print("did tap purchase product: \(skproduct.productIdentifier)")
        isDisabled = true
        IAPManager.shared.purchaseProduct(product: skproduct, success: { 
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
        }) { (error) in
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
        }        
    }
}


