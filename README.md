# ZarinPal In App Billing - Purchase SDK | MPG

ZarinPal Purchase SDK Provides payment methods on your iOS Application.



<p align="center" width="100%">
<img src="https://avatars.githubusercontent.com/u/13906725?s=200&v=4" alt="ZarinPal Logo"/>
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
     pod 'ZarinPal', '~> 1.1.18'
     pod 'ZarinPal_MPG', '~> 1.1.18'
end
```

Install pods:

```
pod install
```
or
```
pod install --repo-update
```

# How to use
###### Step 1

```Swift
import ZarinPal

```

###### Step 2

For `purchase` you need a `ZarinPalBillingClient` instance, `newBuilder` has two type of Payment:

*   as **Payment Request** by `Purchase.newBuilder().asPaymentRequest()`
*   as **Authority ID** by `Purchase.newBuilder().asAuthority()`
*   as **SKU** by `Purchase.newBuilder().asSku()`

If you would create payment Authority on Client, You must use `Purchase.newBuilder().asPayementRequest()`, this method needs below parameters:

**Require Parameters:**

*   Merchant ID: An unique ID of your business payment gateway [ZarinPal Panel](https://next.zarinpal.com/panel/dashboard)
*   Amount: Amount of Purchase.
*   Callback URL: A valid `URI` or `URL` Address for sending result purchase.
*   Description: A Content for showing payer.

[ZarinPal Docs](https://docs.zarinpal.com/paymentGateway/)

**Optional Parameters:**

*   Mobile: Valid Mobile number of payer.
*   Email: Valid Email Address of payer.


Create payment request:
you can add custom URL Schema or your domain: [Docs](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)


```Swift
   let callbackURL = "https://www.your_domain.com/payment" // or mycustomschema://my.app.payment
   let purchase = Purchase.newBuilder()
                    .asPaymentRequest(merchantID: "YOUR MERCHANT ID", amount: 10000, callbackURL: callbackURL, description: "Test Description for this payment")
                    .setType(type: .SHETAB) // or .ALL
                    .build()
```
Or

Maybe You got `Authority` from your server, here You must use `Purchase.newBuilder().asAuthority()`
```Swift
    let purchase = Purchase.newBuilder()
    .asAuthority("AUTHORITY")
    .build()
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

      func didReceive(receipt: [String:Any]?, raw: String?) {
          print("receipt : \(String(describing: receipt)) | raw : \(String(describing: raw)) ")
      }
}
```

###### Step 4

Create ZarinPal Class and pass payment request and delegate:

```Swift
     let zarinPal = ZarinPalBillingClient.newBuilder(viewController: self)
            .setDelegate(self)
            .build()

      let purchase = Purchase.newBuilder()
            .asSku(id: "YOUR PRODUCT ID")
            .setType(type: .SHETAB)
            .build()

     zarinPal.launchBillingFlow(purchase: purchase)
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

          let callbackURL = "https://www.your_domain.com/payment" // or mycustomschema://my.app.payment

          let purchase = Purchase.newBuilder()
                    .asPaymentRequest(merchantID: "YOUR MERCHANT ID", amount: 10000, callbackURL: callbackURL, description: "Test Description for this payment")
                    .setType(type: .SHETAB) // or .ALL
                    .build()

  //let purchase = Purchase.newBuilder()
  //          .asSku(id: "377443")
  //          .setType(type: .SHETAB)
  //          .build()

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


```


And you can get user last purchaes with call query for mobile, cardpan and user email:

```Swift
        let skus = ["PRODUCT ID"]

        let skuParams = SkuQueryParams.newBuilder(merchantID: "MERCHANT CODE")
            .setSkuList(skus)
            .orderByMobile("MOBILE")
            .orderByCardPan("CARD PAN")
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
