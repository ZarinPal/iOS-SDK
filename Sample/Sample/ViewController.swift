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
    let merchantID = "your merchant id"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        
        let purchase = Purchase.asPaymentRequest(merchantID: self.merchantID, amount: 1010, callbackURL: "https://www.google.com", description: "تست توضیحات")
        
   // let purchase = Purchase.asSku(id: "377443")
      
      let zarinPal = ZarinPalBillingClient.newBuilder(viewController: self)
          .setDelegate(self)
          .build()
   
      zarinPal.purchase(purchase: purchase)
    }
    
    func didClose() {
        print("did close")
    }
    
    func didException(exception: NSException) {
        print("exception : \(exception.description)")
    }
    
    func didReceive(receipt: ReceiptShaparak, raw: String) {
        print("receipt : \(receipt)")
    }
    
}

