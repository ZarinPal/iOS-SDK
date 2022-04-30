//
//  ViewController.swift
//  Sample
//
//  Created by ZarinPal on 6/2/21.
//

import UIKit
import ZarinPal

class ViewController: UIViewController,PaymentDelegate {
    
#warning("Please get your merchant id from ZarinPal panel(https://next.zarinpal.com/panel/dashboard)")
    let merchantID = "610c1652-bec2-4d70-a946-c818d199cd97"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        let amount:Int64 = 1010
        
        let callbackURL = "farshid://com.payment" // or custom URL Schema for open the app(https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)
        
        let description = "Test Payment Description"
        
        
        let purchase = Purchase.newBuilder()
            .asPaymentRequest(merchantID: self.merchantID, amount: amount, callbackURL: callbackURL, description: description)
            .setType(type: .SHETAB)
            .build()
        
        //        let purchase = Purchase.newBuilder()
        //            .asSku(id: "377443")
        //            .setType(type: .SHETAB)
        //            .build()
        
        
        let zarinPal = ZarinPalBillingClient.newBuilder(viewController: self)
            .setDelegate(self)
            .build()
        
        zarinPal.launchBillingFlow(purchase: purchase)
    }
    
    func didClose() {
        print("did close")
    }
    
    func didException(exception: NSException) {
        print("exception : \(exception.description)")
    }
    
    func didReceive(receipt: [String:Any]?, raw: String?) {
        print("receipt : \(String(describing: receipt)) | raw : \(String(describing: raw)) ")
    }
    
}

