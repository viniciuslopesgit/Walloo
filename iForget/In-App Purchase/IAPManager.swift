

import UIKit
import StoreKit
import Combine

public typealias SuccessBlock = () -> Void
public typealias FailureBlock = (Error?) -> Void
public typealias ProductsBlock = ([SKProduct]) -> Void

let IAP_PRODUCTS_DID_LOAD_NOTIFICATION = Notification.Name("IAP_PRODUCTS_DID_LOAD_NOTIFICATION")

class IAPManager : NSObject{
    
    private var sharedSecret = "3a3fda3d14b346b3bb2adbb69aa4e798"
    @objc static let shared = IAPManager()
    @objc private(set) var products = [SKProduct]()
    
    private override init(){}
    private var productIds : Set<String> = []
    
    private var didLoadsProducts : ProductsBlock?
    
    private var successBlock : SuccessBlock?
    private var failureBlock : FailureBlock?
    
    private var refreshSubscriptionSuccessBlock : SuccessBlock?
    private var refreshSubscriptionFailureBlock : FailureBlock?
    
    // MARK:- Main methods
    
    @objc func startWith(arrayOfIds : Set<String>!, sharedSecret : String, callback : @escaping  ProductsBlock){
        SKPaymentQueue.default().add(self)
        self.didLoadsProducts = callback
        self.sharedSecret = sharedSecret
        self.productIds = arrayOfIds
        loadProducts()
    }
    
    func expirationDateFor(_ identifier : String) -> Date?{
        return UserDefaults.standard.object(forKey: identifier) as? Date
    }
    
    func isActive(product : SKProduct) -> Bool {
        if let date = expirationDateFor(product.productIdentifier), Date() < date {
            return true
        } else {
            return false
        }
    }
    
    func purchaseProduct(product : SKProduct, success: @escaping SuccessBlock, failure: @escaping FailureBlock){
        
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        guard SKPaymentQueue.default().transactions.last?.transactionState != .purchasing else {
            return
        }        
        self.successBlock = success
        self.failureBlock = failure
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases(success: @escaping SuccessBlock, failure: @escaping FailureBlock){
        self.successBlock = success
        self.failureBlock = failure
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    /* It's the most simple way to send verify receipt request. Consider this code as for learning purposes. You shouldn't use current code in production apps.
     This code doesn't handle errors.
     */
    func refreshSubscriptionsStatus(callback : @escaping SuccessBlock, failure : @escaping FailureBlock){
        
        self.refreshSubscriptionSuccessBlock = callback
        self.refreshSubscriptionFailureBlock = failure
        
        guard Bundle.main.appStoreReceiptURL != nil else {
            refreshReceipt()
            // do not call block in this case. It will be called inside after receipt refreshing finishes.
            return
        }
        
        #if DEBUG
        let urlString = "https://sandbox.itunes.apple.com/verifyReceipt"
        #else
        let urlString = "https://buy.itunes.apple.com/verifyReceipt"
        #endif
        
        guard let receiptURL = Bundle.main.appStoreReceiptURL, let receiptString = try? Data(contentsOf: receiptURL).base64EncodedString() , let url = URL(string: urlString) else {
            return
        }
        
        let requestData : [String : Any] = ["receipt-data" : receiptString,
                                            "password" : "3a3fda3d14b346b3bb2adbb69aa4e798",
                                            "exclude-old-transactions" : true]
        let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            self.refreshSubscriptionFailureBlock?(error)
            self.cleanUpRefeshReceiptBlocks()
            
        }.resume()
    }
    
    /* It's the most simple way to get latest expiration date. Consider this code as for learning purposes. You shouldn't use current code in production apps.
     This code doesn't handle errors or some situations like cancellation date.
     */
    private func parseReceipt(_ json : Dictionary<String, Any>) {
        guard let receipts_array = json["latest_receipt_info"] as? [Dictionary<String, Any>] else {
            self.refreshSubscriptionFailureBlock?(nil)
            self.cleanUpRefeshReceiptBlocks()
            return
        }
        for receipt in receipts_array {
            let productID = receipt["product_id"] as! String 
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            if let date = formatter.date(from: receipt["expires_date"] as! String) {
                if date > Date() || UserDefaults.standard.object(forKey: productID) == nil{
                    // do not save expired date to user defaults to avoid overwriting with expired date
                    UserDefaults.standard.set(date, forKey: productID)
                }
            }
        }
        self.refreshSubscriptionSuccessBlock?()
        self.cleanUpRefeshReceiptBlocks()
    }
    
    /*
     Private method. Should not be called directly. Call refreshSubscriptionsStatus instead. 
     */
    private func refreshReceipt(){
        let request = SKReceiptRefreshRequest(receiptProperties: nil)
        request.delegate = self
        request.start()
    }
    
    private func loadProducts(){
        let request = SKProductsRequest.init(productIdentifiers: productIds)
        request.delegate = self
        request.start()
    }
    
    private func cleanUpRefeshReceiptBlocks(){
        self.refreshSubscriptionSuccessBlock = nil
        self.refreshSubscriptionFailureBlock = nil
    }
}

// MARK:- SKReceipt Refresh Request Delegate

extension IAPManager : SKRequestDelegate {
    
    func requestDidFinish(_ request: SKRequest) {
        if request is SKReceiptRefreshRequest {
            refreshSubscriptionsStatus(callback: self.successBlock ?? {}, failure: self.failureBlock ?? {_ in})
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error){
        if request is SKReceiptRefreshRequest {
            self.refreshSubscriptionFailureBlock?(error)
            self.cleanUpRefeshReceiptBlocks()            
        }
        print("error: \(error.localizedDescription)")
    }
}

// MARK:- SKProducts Request Delegate

extension IAPManager: SKProductsRequestDelegate {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {                
        products = response.products
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: IAP_PRODUCTS_DID_LOAD_NOTIFICATION, object: nil)
            if response.products.count > 0 {
                self.didLoadsProducts?(self.products)
                self.didLoadsProducts = nil
            }
            
        }
    }
}

// MARK:- SKPayment Transaction Observer

extension IAPManager: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                notifyIsPurchased(transaction: transaction)
                
                UserDefaults.standard.set(true, forKey: "proBuy")
                
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchase error : \(transaction.error?.localizedDescription ?? "")")
                self.failureBlock?(transaction.error)
                cleanUp()
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                notifyIsPurchased(transaction: transaction)
                
                UserDefaults.standard.set(true, forKey: "proBuy")
                
                break
            case .deferred, .purchasing:
                break
            default:
                break
            }
        }
    }
    
    private func notifyIsPurchased(transaction: SKPaymentTransaction) {
        refreshSubscriptionsStatus(callback: { 
            self.successBlock?()
            self.cleanUp()
        }) { (error) in            
            // couldn't verify receipt
            self.failureBlock?(error)
            self.cleanUp()
        }
    }
    
    func cleanUp(){
        self.successBlock = nil
        self.failureBlock = nil
    }
}
