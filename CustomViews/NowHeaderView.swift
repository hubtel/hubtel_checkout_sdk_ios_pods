//
//  NowHeaderView.swift
//
//
//  Created by Mark Amoah on 10/10/23.
//

import UIKit

class NowHeaderView: UIView {

    let nowLabel = MyCustomLabel(text: "Now", font: FontManager.getAppFont(size: .m4, weight: .bold))
    
    let amountLabel = MyCustomLabel(text: "Now", font: FontManager.getAppFont(size: .m4, weight: .bold), textAlignment: .right)
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nowLabel, amountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    lazy var parentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [horizontalStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stack.distribution = .fill
        return stack
    }()
    
    convenience init(amount: String){
        self.init(frame: .zero)
        addSubview(parentStack)
        self.amountLabel.text = amount
        backgroundColor = Colors.appGrey
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


class AmountHeaderView: UIView {

    let nowLabel = MyCustomLabel(text: "Now", font: FontManager.getAppFont(size: .m4))
    
    let amountLabel = MyCustomLabel(text: "Now", font: FontManager.getAppFont(size: .m4), textAlignment: .right)
    
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nowLabel, amountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    let divider: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = Colors.appGrey
        return dividerView
    }()
    
    lazy var parentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [horizontalStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stack.distribution = .fill
        return stack
    }()
    
    convenience init(date: String, amount: String){
        self.init(frame: .zero)
        self.nowLabel.text = date
        self.amountLabel.text = amount
        addSubview(parentStack)
        addSubviews(divider)
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
        
        let dividerConstraints = [
            divider.heightAnchor.constraint(equalToConstant: 1.0),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(dividerConstraints)
        
    }

}
