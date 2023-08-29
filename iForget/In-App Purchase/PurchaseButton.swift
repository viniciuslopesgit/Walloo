
import Foundation
import SwiftUI
import StoreKit

struct PurchaseButton : View {
    
    var block : SuccessBlock!
    var product : SKProduct!
    var productsO : ProductsStore?
    
    @State private var compareProduct = ""
    @Binding var selectPurchase: Int
    var body: some View {
        
        VStack(spacing: 0){
            
            Button(action: {
                self.block()
            }) {
                
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.001))
                
            }
            .frame(height: 47)
        }
        .opacity(self.selectPurchase == 0  && self.compareProduct == "com.app.iForgetYearly" ? 0 : 1)
        .onAppear{
            self.compareProduct = self.product.productIdentifier
        }
    }
}
