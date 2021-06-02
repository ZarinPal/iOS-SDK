//
//  ViewController.swift
//  Sample
//
//  Created by ZarinPal on 6/2/21.
//

import UIKit
import ZarinPal

class ViewController: UIViewController,PaymentCallback {
    
    #warning("Please get your merchant id from ZarinPal panel(https://next.zarinpal.com/panel/dashboard)")
    let merchantID = "your merchant id"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        
        let request = Request.asPaymentRequest(merchantID: self.merchantID, amount: 1000, callbackURL: "https://www.google.com", description: "your descaription for payment")
        
        let zarinPal = ZarinPal()
        zarinPal.start(request: request, callback: self,vc: self)
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

