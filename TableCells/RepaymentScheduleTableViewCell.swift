//
//  RepaymentScheduleTableViewCell.swift
//
//
//  Created by Mark Amoah on 10/24/23.
//

import UIKit

struct RepaymentScheduleDisplay: Listable{
    var listableType: cellIdentifier
    
    func getListableType() -> cellIdentifier {
        return listableType
    }
}

class RepaymentScheduleTableViewCell: UITableViewCell {
    
    static let identifier: String = "repaymentScheduleIdentifier"
    
    let installments = [
        Installments(period: "Now", amount: "GHS 330"),
        Installments(period: "12th, August 2023", amount: "GHS 250"),
        Installments(period: "19th August 2023", amount: "GHS 250"),
        Installments(period: "26th, August 2023", amount: "GHS 250")
    ]
    
    let titleLabel: MyCustomLabel = MyCustomLabel(text: "Repayment Schedule", font: FontManager.getAppFont(size: .m4, weight: FontWeight.bold))
    
    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var installmentsView = InstallmentFieldsView(installments: installments)
    
    lazy var parentView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, installmentsView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(parentView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        let stackViewConstraints = [
            parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    

}
