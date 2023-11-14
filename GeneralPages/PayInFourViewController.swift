//
//  PayInFourViewController.swift
//
//
//  Created by Mark Amoah on 10/9/23.
//

import UIKit

protocol PerformPayIn4Delegate{
    func showPaymentDetails()
}

enum cellIdentifier{
    case amountTab
    case descriptionTab
    case tableTab
}

protocol Listable {
    var listableType: cellIdentifier { get set }
    func getListableType()->cellIdentifier
}

class PayInFourViewController: UIViewController {
    
    var delegate: PerformPayIn4Delegate?
    
    var contentAmounts : [Listable] = [
        AmountDisplay(listableType: .amountTab, title: "Amount", amount: "GHS 1000"), AmountDisplay(listableType: .amountTab, title: "Interest", amount: "GHS 80.0"), AmountDisplay(listableType: .amountTab, title: "Interest Rate", amount: "8%"), BoldedTextHolder(listableType: .amountTab, text: "Note that the interest of Ghana cedis 80.00 will be paid on your first installment"),
        RepaymentScheduleDisplay(listableType: .tableTab),
        BoldedTextHolder(listableType: .amountTab, text: "You are obligated to make payments as outlined within this period of time. Failure to make payments on time may lead to increased interest rates, damage to your credit score and potential legal action"),
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    let bottomButton: CustomButtonView = {
        let button = CustomButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonTitle(with: "CONFIRM AND PAY")
        button.validate(true)
        return button
    }()
    
    let payInFourTitle = MyCustomLabel(text: "Pay-In-4", font: FontManager.getAppFont(size: .m4, weight: .bold))
    
    let closeButton: UIButton = {
        let button = UIButton()
        var blackImage: UIImage?
        if #available(iOS 13.0, *) {
            blackImage = imageNamed("close_black_light")
        } else {
         blackImage = imageNamed("close_black_light")
        }
        button.setImage(blackImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(
            AmountDisplayTableViewCell.self, forCellReuseIdentifier: AmountDisplayTableViewCell.identifier)
        tableView.register(BoldedDescTableViewCell.self, forCellReuseIdentifier: BoldedDescTableViewCell.identifier)
        tableView.register(RepaymentScheduleTableViewCell.self, forCellReuseIdentifier: RepaymentScheduleTableViewCell.identifier)
        view.addSubviews(payInFourTitle, closeButton, tableView)
        view.addSubview(bottomButton)
        bottomButton.delegate = self
        setupConstraints()
    }
    
    
    func setupConstraints(){
        
        
        let payFourTitleConstraints = [
            payInFourTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            payInFourTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ]
        
        NSLayoutConstraint.activate(payFourTitleConstraints)
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: payInFourTitle.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
        
        let buttonConstraints = [
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        
        let closeButtonConstraints = [
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 16)
        ]
        NSLayoutConstraint.activate(closeButtonConstraints)
    }
    

    

}

extension PayInFourViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentAmounts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listable = contentAmounts[indexPath.row].getListableType()
        
        switch listable{
            
        case .amountTab:
            let cell = tableView.dequeueReusableCell(withIdentifier: AmountDisplayTableViewCell.identifier, for: indexPath) as! AmountDisplayTableViewCell
            cell.setupCell(with: contentAmounts[indexPath.row] as! AmountDisplay
            )
            return cell
            
            
        case .descriptionTab:
            let cell = tableView.dequeueReusableCell(withIdentifier:  BoldedDescTableViewCell.identifier, for: indexPath) as! BoldedDescTableViewCell
            cell.setupCell(description: (contentAmounts[indexPath.row] as! BoldedTextHolder).text
            )
            return cell
        case .tableTab:
            let cell = tableView.dequeueReusableCell(withIdentifier: RepaymentScheduleTableViewCell.identifier, for: indexPath) as! RepaymentScheduleTableViewCell
            return cell
        }
    }

}

extension PayInFourViewController: ButtonActionDelegate{
    func performAction() {
        self.dismiss(animated: true) {
            self.delegate?.showPaymentDetails()
        }
    }
}
