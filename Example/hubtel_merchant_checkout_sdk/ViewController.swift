//
//  ViewController.swift
//  hubtel_merchant_checkout_sdk
//
//  Created by 85908865 on 11/04/2023.
//  Copyright (c) 2023 85908865. All rights reserved.
//

import UIKit
import hubtel_merchant_checkout_sdk

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button  = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me to checkout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openCheckout), for: .primaryActionTriggered)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        setupConstraints()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func openCheckout(){
        
        let configuration = HubtelCheckoutConfiguration(merchantId: "2017", callbackUrl: "https://d6e5-154-160-20-114.ngrok-free.app/payment/callback", merchantApiKey: "")
        
        let purchaseInfo = PurchaseInfo(amount: 1, customerPhoneNumber: "0247798939", purchaseDescription: "This is a desc", clientReference:UUID().uuidString)
        
        CheckoutViewController.presentCheckout(from: self, with: configuration, and: purchaseInfo, delegate: self, tintColor: UIColor.black)
    }
    
    func setupConstraints(){
        let buttonConstraints = [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: PaymentFinishedDelegate{
    func checkStatus(value: hubtel_merchant_checkout_sdk.PaymentStatus, transactionId: String) {
        print(value, transactionId)
    }
    
    
}
