//
//  BoldedDescTableViewCell.swift
//
//
//  Created by Mark Amoah on 10/24/23.
//

import UIKit

struct BoldedTextHolder: Listable{
    var listableType: cellIdentifier
    
    func getListableType() -> cellIdentifier {
        return .descriptionTab
    }
    
    let text: String
}

class BoldedDescTableViewCell: UITableViewCell {
    
    static let identifier: String = "BoldedText"
    
    let textDesc: MyCustomLabel = MyCustomLabel(text: "", font: FontManager.getAppFont(size: .m4, weight: .bold))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews(textDesc)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupCell(description: String){
        self.textDesc.text = description
    }
    
    func setupConstraints(){
        let textDescConstraints = [
            textDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textDesc.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(textDescConstraints)
    }
    
}
