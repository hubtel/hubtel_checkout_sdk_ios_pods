//
//  AmountDisplayTableViewCell.swift
//
//
//  Created by Mark Amoah on 10/9/23.
//

import UIKit


struct AmountDisplay: Listable{
    var listableType: cellIdentifier
    var title: String
    var amount: String
    
    func getListableType() -> cellIdentifier {
        return listableType
    }
    
}

class AmountDisplayTableViewCell: UITableViewCell {
    
    static let identifier = "amountDisplayIdentifier"
    
    let amountDescLabel = MyCustomLabel(text: "")
    
    let amount = MyCustomLabel(text: "", font: FontManager.getAppFont(size: .m4, weight: .bold))
    
    let divider: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = Colors.appGrey
        return dividerView
    }()
    
    
    
    lazy var horizontalStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [amountDescLabel, amount])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fill
        return stackview
    }()
    
    
    lazy var parentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(divider,parentStack)
        amount.textAlignment = .right
        selectionStyle = .none
        setupConstraints()
    }
    
    
    func setupConstraints(){
        let parentStackConstraints = [
            parentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(parentStackConstraints)
        
        let dividerConstraints = [
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(dividerConstraints)
    }
    
    func setupCell(with content: AmountDisplay){
        amountDescLabel.text = content.title
        amount.text  = content.amount
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
