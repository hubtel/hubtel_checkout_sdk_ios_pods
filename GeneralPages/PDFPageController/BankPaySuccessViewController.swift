//
//  BankPaySuccessViewController.swift
//
//
//  Created by Mark Amoah on 10/19/23.
//

import UIKit

class BankPaySuccessViewController: UIViewController {
    
    let checkMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleDesc: MyCustomLabel = MyCustomLabel(text: "Download Complete", font: FontManager.getAppFont(size: .m5, weight: .bold), textAlignment: .center, color: Colors.black)
    
    let descriptionLabel: UILabel = MyCustomLabel(text: "", font: FontManager.getAppFont(size: .m4), textAlignment: .center, color: Colors.black)
    
    let bottomButton: CustomButtonView = {
        let button = CustomButtonView()
        button.validate(true)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Confirm Pay"
        
        view.addSubviews(checkMarkImage, descriptionLabel, titleDesc)
    }
    
    
    func setupConstraints(){
        let checkMarkConstraints = [
            checkMarkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMarkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(checkMarkConstraints)
        
        let titleDescConstraints = [
            titleDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleDesc.topAnchor.constraint(equalTo: checkMarkImage.bottomAnchor, constant: 8)
        ]
    }
    

    

}
