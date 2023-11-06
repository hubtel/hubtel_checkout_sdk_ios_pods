# hubtel_merchant_checkout_sdk

[![CI Status](https://img.shields.io/travis/85908865/hubtel_merchant_checkout_sdk.svg?style=flat)](https://travis-ci.org/85908865/hubtel_merchant_checkout_sdk)
[![Version](https://img.shields.io/cocoapods/v/hubtel_merchant_checkout_sdk.svg?style=flat)](https://cocoapods.org/pods/hubtel_merchant_checkout_sdk)
[![License](https://img.shields.io/cocoapods/l/hubtel_merchant_checkout_sdk.svg?style=flat)](https://cocoapods.org/pods/hubtel_merchant_checkout_sdk)
[![Platform](https://img.shields.io/cocoapods/p/hubtel_merchant_checkout_sdk.svg?style=flat)](https://cocoapods.org/pods/hubtel_merchant_checkout_sdk)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You can also run `pod try hubtel_merchant_checkout_sdk` in your terminal if you have cocoapods installed to clone and test the example project.



## Installation

hubtel_merchant_checkout_sdk is available through [CocoaPods](https://cocoapods.org/pods/hubtel_merchant_checkout_sdk). To install
it, simply add the following line to your Podfile:

```ruby
pod 'hubtel_merchant_checkout_sdk'
```
## Installation
Run `pod install hubtel_merchant_checkout_sdk`

## Getting Started

_Objects needed_
| Properties | Explanation |
|--|--|
|**`HubtelCheckoutConfiguration`**|is an object used for payment processing with Hubtel Checkout service. It enables merchants to set their identification, specify a callback URL for payment notifications, and secure transactions with a merchant API key.|
| **`merchantId`** (required) |given to the merchant to use the sdk. This is one of three parameters to passed the `configuration object`.|
| **`merchantApiKey`** (required) | Base64 encoded string of the customer’s id and password. Also passed to the `configuration object`.|
| **`callbackUrl`** (required)| A url provided by the merchant in order to be able to listen for callbacks from the payment api to know the status of payments. Also passed to the `configuration object`.|
|**`PurchaseInfo`**|Information about the purchase to process. Details are given below.|
| **`amount`** (required) | The price of the item or service the customer is trying to purchase from.|
| **`customerPhoneNumber`** (required) | A required mobile number of the customer purchasing the item.|
| **`purchaseDescription`** (required)| An optional description attached to the purchase. |
| **`tintColor`**|a UIColor of your choosing, or rather your design's.|
|**`Delegate Object`**|an object that implements the `PaymentFinishedDelegate` in order to get information about UI changes from the sdk.|

## Integration

1. Import `hubtel_merchant_checkout_sdk` in the ViewController where payment is to be initiated.
2. Create a `HubtelCheckoutConfiguration` object, like so:
```swift
let configuration = HubtelCheckoutConfiguration(merchantId: "11624", callbackUrl: "https://9cb7-154-160-1-110.ngrok-free.app/payment-callback", merchantApiKey: "T0UwbjAzcko9ZjAxMzhkOTk5ZmM0ODMxYjc3MWFhMzEzYTNjNQhhNA==")
```
3. Create a `PurchaseInfo` object, like so:
```swift
let purchaseInfo = PurchaseInfo(amount: 1, customerPhoneNumber: "0545454545", purchaseDescription: "This is a desc", clientReference:self.uuid.uuidString)
```
4. On your pay button having all necessary info set, call `presentCheckout`, like so:
```swift
CheckoutViewController.presentCheckout(from: self, with: configuration, and: purchaseInfo, delegate: self, tintColor: UIColor.black)
```

The calling controller must implement the `PaymentFinishedDelegate` protocol to be able to see the checkout status.

The `PaymentFinishedDelegate` protocol has a function with a single parameter value of type `PaymentStatus`

### PaymentStatus Cases
The `PaymentStatus` is an enum displaying the status of payment. It contains the following cases:

- `userCancelledPayment`: When the user closes the checkout page without performing any transaction.
- `paymentFailed`: When the user performs a transaction but payment fails.
- `paymentSuccessful`: When the user finally pays successfully.
- `unknown`: When the user cancels transaction after payment attempt without checking status.

### Example
```swift
extension ViewController: PaymentFinishedDelegate {

    func checkStatus(value: PaymentStatus) {
    }
}

```

## Screenshots

![Fig. 01](https://firebasestorage.googleapis.com/v0/b/newagent-b6906.appspot.com/o/hubtel-mobile-checkout-ios-sdk-image.png?alt=media&token=376d90ab-c416-42a0-8b99-69028378ff72)

## Author

Mark Amoah, markamoah97@gmail.com

## License

hubtel_merchant_checkout_sdk is available under the MIT license. See the LICENSE file for more info.

