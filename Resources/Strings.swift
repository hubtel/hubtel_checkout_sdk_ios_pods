//
//  File.swift
//
//
//  Created by Mark Amoah on 5/31/23.
//

import Foundation
import UIKit


class Strings{
    static let payWith = "Select payment method"
    static let bankCard = "Bank Card"
    static let emptyString = ""
    static let regularSans = "NunitoSans-Regular"
    static let fontExtension = "ttf"
    static let extraBoldSans = "NunitoSans-ExtraBold"
    static let sansSemiBold = "NunitoSans-SemiBold"
    static let alert = "Alert"
    static let wantToCancelTransaction = "Do you want to cancel this transation?"
    static let no = "No"
    static let yes = "Yes"
    static let myCard = "myCard"
    static let useSavedCard = "Use a saved card"
    static let useNewCard = "Use a new card"
    static let bankPaymentCell = "BankPaymentCell"
    static let cardNumberPlaceHolder = "1234 5678 9223 2234"
    static let accountHolderPlaceHolder = "Name on Card"
    static let expiryPlaceHolder = "MM/YY"
    static let cvvPlaceHolder = "cvv"
    static let saveCardForFutureUse = "Save this card for future use"
    static let validationErrors = "Validation Errors"
    static let somethingWentWrong = "Something Went wrong"
    static let ValidationErrors = "Incorrect details on card entered, please check"
    static let mobileMoneyNumberTakerPlaceHolder = "Enter your mobile money number"
    static let mobileMoney = "Mobile Money"
    static func setMomoPrompt(with mobileNumber: String)->String{
        return "A bill prompt has been sent to \(mobileNumber). Please authorise the payment."
    }
    static let directDebitText = "Your payment is being processed. Tap the\nbutton below to check payment status"
    static let success =  "Success"
    static let confirmOrder = "Confirm Order"
    static let checkStatus = "CHECK STATUS"
    static let agreeAndContinue = "AGREE & CONTINUE"
    
    static func generateOtpPromptText(mobileNumber: String, otpPrefix: String)->String{
        return "Enter verification code sent to\n\(mobileNumber) starting with \(otpPrefix)"
    }
    
    static let others = "Others"
    
    static let hubtelWalletDescString = "Your balance on Hubtel will be debited immediately you confirm payment.\n\nNo authorization prompt will be sent to you"
    
    static let gmoneyDescString = "You will be required to enter your mandate ID to confirm your transaction"
    
    static let stepsForOrder = "Steps to authorize the payment process.\n 1. Dial *270#\n 2. Select Option 8 (Account)\n 3. Select Option 4 (Approve Payment)\n 4. Enter Pin to make Payment"
    
    static func getSteps()->NSMutableAttributedString{
        let steps  = NSMutableAttributedString(string: "Steps to authorize the payment process.", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
        
    steps.append(NSAttributedString(string: "\n 1. Dial *270#\n 2. Select Option 8 (Account)\n 3. Select Option 4 (Approve Payment)\n 4. Enter Pin to make Payment.", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        return steps
    }
    
    static let mandateIdTitle: String = "Mandate ID"
    
    
    static func generateMandateIdDescriptionText()->NSMutableAttributedString{
        let steps  = NSMutableAttributedString(string: "Steps to genrate a mandate ID on G-Money\n\n", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
          
        steps.append(NSAttributedString(string: "1 ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
      )
        steps.append(NSAttributedString(string: "Dial *422#\n\n", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
      )
        
        
        
        
        steps.append(NSAttributedString(string: "2 ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
        )
        
        steps.append(NSAttributedString(string: " Select option 2(G-money)\n\n", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
      )
        
        steps.append(NSAttributedString(string: "3 ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
        )
        
        steps.append(NSAttributedString(string: " Select Option 4(Payment Services)\n\n", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
      )
        
        steps.append(NSAttributedString(string: "4 ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
                    )
        steps.append(NSAttributedString(string: " Select Option 6(Mandate)\n\n", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
      )
                     
        steps.append(NSAttributedString(string: "5 ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
        )
        steps.append(NSAttributedString(string: " Select Option 1 (Create Mandate)\n\n", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
      )
          
        return steps
    }
    
    static let Bankpay = "Bank Pay"
    
    static let payIn4 = "Pay in 4"
    
    static func generateBoldedAmount(amount: String)->NSAttributedString{
        return NSAttributedString(string: " GHS \(amount) ", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4, weight: .bold)])
    }
    
    static func generatePayIn4String(totalAmount: String, paymentAmountForNow: String, remainingAmount: String)-> NSMutableAttributedString{
        let paymentDesc = NSMutableAttributedString(string: "You qualify for your item of", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
        
        paymentDesc.append(generateBoldedAmount(amount: totalAmount))
        
        paymentDesc.append(NSAttributedString(string: "in 4 splits", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(NSAttributedString(string: "\n\nFor this",attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(generateBoldedAmount(amount: totalAmount))
        
        paymentDesc.append(NSAttributedString(string: "you may pay", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(generateBoldedAmount(amount: paymentAmountForNow))
        
        paymentDesc.append(NSAttributedString(string: "now.", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(NSAttributedString(string: "\n\nPay only",attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(generateBoldedAmount(amount: paymentAmountForNow))
        
        paymentDesc.append(NSAttributedString(string: "now. The remaining", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        paymentDesc.append(generateBoldedAmount(amount: remainingAmount))
        
        paymentDesc.append(NSAttributedString(string: "will be debited in three equal installments", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)]))
        
        return paymentDesc
        
    }
    
    static func generateBackedByString() -> NSMutableAttributedString{
        let backedDesc = NSMutableAttributedString(string: "Pay in 4 is backed by Letshego under ", attributes: [ NSAttributedString.Key.font: FontManager.getAppFont(size: .m4)])
        backedDesc.append(NSAttributedString(string: "these terms", attributes: [NSAttributedString.Key.font : FontManager.getAppFont(size: .m4), NSAttributedString.Key.foregroundColor: Colors.teal2, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: Colors.teal2 ]))
        return backedDesc
        
    }
    
}
