//
//  ContactInputField.swift
//  hubtel_merchant_checkout_sdk
//
//  Created by Mark Amoah on 12/11/23.
//

import UIKit

class ContactInputField: UIView {
    
    let flagImage: ProviderImageView = {
        let providerImage = ProviderImageView(imageName: "")
        return providerImage
    }()

    let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+233"
        label.font = FontManager.getAppFont(size: .m4, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let providerLabel: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.getAppFont(size: .m4)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.tag = Tags.contactInputView
        return label
    }()
    
    let carretImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            imageView.image = imageNamed("caret_down")
        }else{
            imageView.image = imageNamed("caret_down")
        }
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var componentsHolder: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [flagImage,countryCodeLabel,providerLabel,providerLabel, carretImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
//        stack.distribution = .fillProportionally
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        stack.spacing = 8
        return stack
    }()
    
    init(provider: String, frame: CGRect){
        super.init(frame: frame)
        providerLabel.text = provider
        addSubview(componentsHolder)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.fieldColor
        layer.cornerRadius = 8
        isUserInteractionEnabled = true
        flagImage.installImage(imageString: "Flag")
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints(){
        let componentsHolderConstraints = [componentsHolder.leadingAnchor.constraint(equalTo: leadingAnchor), componentsHolder.trailingAnchor.constraint(equalTo: trailingAnchor), componentsHolder.topAnchor.constraint(equalTo: topAnchor), componentsHolder.bottomAnchor.constraint(equalTo: bottomAnchor)]
        NSLayoutConstraint.activate(componentsHolderConstraints)
        let caretConstraints = [carretImage.heightAnchor.constraint(equalToConstant: 15), carretImage.widthAnchor.constraint(equalToConstant: 15)]
        NSLayoutConstraint.activate(caretConstraints)
    }
    
    func changeProvider(with providerName: String){
        self.providerLabel.text = providerName
    }
    
    func setupString(value: String){
        self.providerLabel.text = value
    }
    
    func getProviderString()->String{
        print(providerLabel.text)
        return providerLabel.text?.lowercased() ?? ""
    }
    
    func getPaymentType()->PaymentType {
        if getProviderString() == "hubtel" || getProviderString() == "hubtel-gh"{
            return .hubtel
        }
        
        if getProviderString() == "zeepay"{
            return .zeepay
        }
        
        if getProviderString() == "g-money"{
            return .gmoney
        }
        return .hubtel
    }

}
