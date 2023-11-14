//
//  Payin4TableViewCell.swift
//
//
//  Created by Mark Amoah on 10/9/23.
//

import UIKit

protocol TermsAndConditionDelegate{
    func viewTerms()
}

struct Installments{
    let period: String
    let amount: String
}


class Payin4TableViewCell: UITableViewCell {
    
    var delegate: BankCellDelegate?
    
    var termsDelegate: TermsAndConditionDelegate?
    
    
    static let identifier = "Payin4Identifier"
    
  
    let installments = [
        Installments(period: "Now", amount: "GHS 330"),
        Installments(period: "12th, August 2023", amount: "GHS 250"),
        Installments(period: "19th August 2023", amount: "GHS 250"),
        Installments(period: "26th, August 2023", amount: "GHS 250")
    ]
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let walletSeletorTab: ProviderSelectorView = {
        let selectorView = ProviderSelectorView(provider: "MTN Mobile Money", frame: .zero )
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.tag = Tags.providerWalletTagSelector
        return selectorView
    }()
    
    let contactSeletorTab: ProviderSelectorView = {
        let selectorView = ProviderSelectorView(provider: "0556236739", frame: .zero )
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.tag = Tags.providerWalletTagSelector
        return selectorView
    }()
    
    let pay4label: MyCustomLabel = MyCustomLabel(text: "Pay-In-4", font: FontManager.getAppFont(size: .m3, weight: .bold))
    
    let backedByLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = Strings.generateBackedByString()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var parentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descLabel, paymentTermsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.axis = .vertical
        stack.alignment = .fill
        stack.backgroundColor = .white
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        return stack
    }()
    
    let paymentTermsLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "View repayment details and terms", attributes: [NSAttributedString.Key.font: FontManager.getAppFont(size: .m3, weight: .bold), NSAttributedString.Key.foregroundColor: Colors.teal2, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var installmentsView = InstallmentFieldsView(installments: installments)
    
    
    
    @objc func viewTermsAndConditions(){
        termsDelegate?.viewTerms()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(parentStack)
        contentView.backgroundColor = UIColor(red: 242.0/255, green: 242.0/255, blue: 242.0/255,alpha:1)
        
        contentView.clipsToBounds =  true
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTermsAndConditions))
        backedByLabel.isUserInteractionEnabled = true
        backedByLabel.addGestureRecognizer(tapGesture)
        paymentTermsLabel.addGestureRecognizer(tapGesture)
        
        self.tag = 33377
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        let parentStackConstraints = [
            parentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            parentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            parentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(parentStackConstraints)
        [walletSeletorTab, contactSeletorTab].forEach { view in
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    func setup(totalAmount: String, installmentAmount: String, remainingAmount: String){
        descLabel.attributedText = Strings.generatePayIn4String(totalAmount: totalAmount, paymentAmountForNow: installmentAmount, remainingAmount: remainingAmount)
    }
    
    
    func setupPaymentInstallments(){
        
        parentStack.arrangedSubviews.forEach { view in
            parentStack.removeArrangedSubview(view)
            view.isHidden =  true
        }
        
        [walletSeletorTab,contactSeletorTab,pay4label, installmentsView, backedByLabel].forEach { view in
            view.isHidden = false
            parentStack.addArrangedSubview(view)
        }
        
        parentStack.setCustomSpacing(24, after: installmentsView)
        
        //TODO: perform batch updates on table
        delegate?.resizeCell?()
    }
    
    
}

extension CheckoutViewController: TermsAndConditionDelegate{
    func viewTerms() {
        let controller = PayInFourViewController()
        self.present(controller, animated: true)
    }
}
