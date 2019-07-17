//
//  InPurchaseManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import StoreKit
import MBProgressHUD

typealias InPurchaseManagerCheckClouse = (_ dic:NSDictionary) ->Void

class InPurchaseManager: NSObject {
    
    var productID:String!
    var loading:MBProgressHUD!
    var inPurchaseManagerCheckClouse:InPurchaseManagerCheckClouse!
    private static let _sharedInstance = InPurchaseManager()
    
    class func getSharedInstance() -> InPurchaseManager {
        return _sharedInstance
    }
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    } // 私有化init方法
    
    //验证是否允许应用内支付
    func gotoApplePay(productID:String) {
        if SKPaymentQueue.canMakePayments() {
            loading = Tools.shareInstance.showLoading(KWindow, msg: "")
            self.requestProductID(productID: productID)
        }else{
            _ = Tools.shareInstance.showMessage(KWindow, msg: "请先开启内购", autoHidder: true)
        }
    }
    
    //从苹果服务器请求商品
    func requestProductID(productID:String){
        self.productID = productID
        let productArr:Array<String> = [productID]
        let sets:Set<String> = NSSet.init(array: productArr) as! Set<String>
        let skRequest:SKProductsRequest = SKProductsRequest.init(productIdentifiers: sets)
        skRequest.delegate = self
        skRequest.start()
    }
    
    func buyProduct(_ product:SKProduct){
        let skpay:SKPayment = SKPayment.init(product: product)
        SKPaymentQueue.default().add(skpay)
    }
    
    
    //获取支付成功的凭证
    func buyAppleProductSuccessWithPaymnetTransaction(_ paymentTransaction:SKPaymentTransaction) {
        //       let productIdentifier = paymentTransaction.payment.productIdentifier
        let url = Bundle.main.appStoreReceiptURL
        let appstoreRequest = URLRequest.init(url: url!)
        do {
            let reciptaData = try NSURLConnection.sendSynchronousRequest(appstoreRequest, returning: nil)
            let transactionRecipsting:String = reciptaData.base64EncodedString(options: .endLineWithLineFeed)
            self.checkAppstorePayResultWithBase64String(transactionRecipsting)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    //将凭证传递给后台服务器，由后台服务去和苹果服务器验证是否购买成功
    func checkAppstorePayResultWithBase64String(_ base64String:String){
        var sandBox = 1
        #if DEBUG
        sandBox = 0
        #endif
        #if APPSTORE_ASK_TO_BUY_IN_SANDBOX
        sandBox = 0
        #endif
        let str = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let dict = ["sandbox":sandBox,"receipt":str] as NSDictionary
        if inPurchaseManagerCheckClouse != nil {
            inPurchaseManagerCheckClouse(dict)
        }
    }
    
}

extension InPurchaseManager : SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:SKPaymentTransaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                loading = Tools.shareInstance.showLoading(KWindow, msg: "正在购买,请稍候...")
            case .purchased:
                loading.hide(animated: true)
                self.buyAppleProductSuccessWithPaymnetTransaction(transaction)
                queue.finishTransaction(transaction)
            case .failed:
                loading.hide(animated: true)
                loading = Tools.shareInstance.showLoading(KWindow, msg: "正在购买,请稍候...")
                _ = Tools.shareInstance.showMessage(KWindow, msg: "连接服务器失败,请重新支付", autoHidder: true)
                queue.finishTransaction(transaction)
            case .restored:
                loading.hide(animated: true)
                queue.finishTransaction(transaction)
            case .deferred:
                loading.hide(animated: true)
                _ = Tools.shareInstance.showMessage(KWindow, msg: "延迟支付", autoHidder: true)
                queue.finishTransaction(transaction)
            default:
                loading.hide(animated: true)
                break;
            }
        }
    }
}

extension InPurchaseManager : SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        loading.hide(animated: true)
        for item:SKProduct in products {
            if item.productIdentifier == self.productID {
                self.buyProduct(item)
            }
        }
    }
}
