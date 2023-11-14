//
//  InstallmentFieldsView.swift
//
//
//  Created by Mark Amoah on 10/10/23.
//

import UIKit



class InstallmentFieldsView: UIView {

    let parentStack: UIStackView  = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    
    convenience init(installments: [Installments]){
        self.init(frame: .zero)
        
        let nowPayment = installments[0]
        
        let nowView = NowHeaderView(amount: nowPayment.amount)
        
        parentStack.addArrangedSubview(nowView)
        
        let otherInstallments = installments[1...]
        
        for installment in otherInstallments{
            
            let amountInstalledView = AmountHeaderView(date: installment.period, amount: installment.amount)
            
            parentStack.addArrangedSubview(amountInstalledView)
        }
        
        addSubview(parentStack)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        let parentStackConstraints = [
            parentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            parentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            parentStack.topAnchor.constraint(equalTo: topAnchor),
            parentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(parentStackConstraints)
    }

}
