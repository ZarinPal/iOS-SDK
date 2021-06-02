# ZarinPal In App Billing - Purchase SDK | MPG

ZarinPal Purchase SDK Provides payment methods on your iOS Application.



<p align="center" width="100%">
<img src="https://github.com/ZarinPal-Lab/Android-PaymentGateway-SDK/blob/master/logo%20%E2%80%93%201.png?raw=true" alt="sample" width="300" height="100"/>
</p>


# Requirements 

- iOS 11.0+ 
- Xcode 12+
- Swift 5.1+

#Installation

Download and add ZarinPal framework in to project(can download release tags).

#How to use

Step 1

```Swift
import ZarinPal
```

Step 2

Create payment request:
```Swift
  let request = Request.asPaymentRequest(merchantID: "your merchant id", amount: 1010, callbackURL: "https://www.google.com", description: "your descaription for payment")
```

Step 3

Add payment protocol in your viewController also add methods:

```Swift
class MyViewController: UIViewController,PaymentCallback {

      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
```

Step 4

Create ZarinPal Class and pass payment request and callback:

```Swift
      let zarinPal = ZarinPal()
      zarinPal.start(request: request, callback: self,vc: self)
```

## DONE

Complete sample code:

```Swift
import UIKit
import ZarinPal

class ViewController: UIViewController,PaymentCallback {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn(_ sender: Any) {
                
       let request = Request.asPaymentRequest(merchantID: "your merchant id", amount: 1010, callbackURL: "https://www.google.com", description: "your descaription for payment")
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


```
