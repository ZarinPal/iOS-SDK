# ZarinPal In App Billing - Purchase SDK | MPG

ZarinPal Purchase SDK Provides payment methods on your iOS Application.



<p align="center" width="100%">
<img src="https://github.com/ZarinPal-Lab/Android-PaymentGateway-SDK/blob/master/logo%20%E2%80%93%201.png?raw=true" alt="ZarinPal Logo" width="300" height="100"/>
</p>


# Requirements 

- iOS 11.0+ 
- Xcode 12+
- Swift 5.1+

# Installation

CocoaPods:

Create Podfile and add ```pod 'ZarinPal'``` and ```ZarinPal_MPG```:

```
use_frameworks!

target 'YourApp' do
     pod 'ZarinPal', '~> 1.1.7'
     pod 'ZarinPal_MPG', '~> 1.1.7'
end
```

Install pods:

```
install pod
```

# How to use
###### Step 1

```Swift
import ZarinPal

```

###### Step 2

For `purchase` you need a `ZarinPalBillingClient` instance, `newBuilder` has two type of Payment:

*   as **Payment Request** by `Purchase.asPaymentRequest()`
*   as **Authority ID** by `Purchase.asAuthority()`
*   as **SKU** by `Purchase.asSku()`

If you would create payment Authority on Client, You must use `Purchase.asPayementRequest()`, this method needs below parameters:

**Require Parameters:**

*   Merchant id: An unique ID of your business payment gateway.
*   Amount: Amount of Purchase.
*   Callback URL: A valid `URI` or `URL` Address for sending result purchase.
*   Description: A Content for showing payer.

**Optional Parameters:**

*   Mobile: Valid Mobile number of payer.
*   Email: Valid Email Address of payer.


Create payment request:
```Swift
  let request = Purchase.asPaymentRequest(merchantID: "your merchant id", amount: 1010, callbackURL: "https://www.google.com", description: "your descaription for payment")
```
Or

Maybe You got `Authority` from your server, here You must use `Purchase.asAuthority()`
```Swift
    let purchase = Purchase.asAuthority("AUTHORITY")
```   

###### Step 3

Add payment delegate in your viewController also add methods:

```Swift
class MyViewController: UIViewController,PaymentDelegate {

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

###### Step 4

Create ZarinPal Class and pass payment request and delegate:

```Swift
     let zarinPal = ZarinPalBillingClient.newBuilder(viewController: self)
            .setDelegate(self)
            .build()
            
     let purchase = Purchase.asSku(id: "377443")
        
     zarinPal.purchase(purchase: purchase)
```

Complete sample code:

```Swift
import UIKit
import ZarinPal

class ViewController: UIViewController,PaymentDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn(_ sender: Any) {
                
            let purchase = Purchase.asPaymentRequest(merchantID: "610c1652-bec2-4d70-a946-c818d199cd97", amount: 1010, callbackURL: "https://www.google.com", description: "تست توضیحات")
          
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


```


And you can get user last purchaes with call query for mobile, cardpan and user email:

```Swift
        let skus = ["377443"]
        
        let skuParams = SkuQueryParams.newBuilder(merchantID: "9b4e73dd-a1d8-430f-a725-3c84d6c65d2e")
            .setSkuList(skus)
            .orderByMobile("09355106005")
            .orderByCardPan("5022291062009996")
            .build()
        
        let zarinPal = ZarinPalBillingClient.newBuilder(viewController: self)
            .setDelegate(self)
            .build()
        
        zarinPal.querySkuPurchased(query: skuParams) { purchase in
            purchase?.forEach({ skuPurchased in
                print(skuPurchased.authority)
            })
            
        }

```

