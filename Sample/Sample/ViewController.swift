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
    let merchantID = "9b4e73dd-a1d8-430f-a725-3c84d6c65d2e"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        
                let purchase = Purchase.newBuilder()
                    .asPaymentRequest(merchantID: self.merchantID, amount: 1010, callbackURL: "https://www.google.com", description: "تست توضیحات")
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

