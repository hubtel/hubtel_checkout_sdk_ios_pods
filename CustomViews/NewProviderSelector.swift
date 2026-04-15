//
//  NewProviderSelector.swift
//  hubtel_merchant_checkout_sdk
//
//  Created by Mark Amoah on 15/04/2026.
//

import Foundation

//
//  MomoProviderBottomSheetViewController.swift
//
//
//  Created by Mark Amoah on 4/15/26.
//

import UIKit

protocol MomoProviderSelectorDelegate: AnyObject {
    func didSelectProvider(name: String, providerId: String, index: Int)
}

class NewProviderSelector: UIViewController{
   
    

    weak var delegate: MomoProviderSelectorDelegate?
    private let providers: [(name: String, id: String)]
    private var selectedIndex: Int = 0

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 2.5
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select a momo provider"
        label.font = FontManager.getAppFont(size: .m4, weight: .bold)
        label.textAlignment = .left
        return label
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(ProviderCell.self, forCellReuseIdentifier: "ProviderCell")
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        table.isScrollEnabled = false
        return table
    }()

    private lazy var selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select", for: .normal)
        button.backgroundColor = Colors.globalColor ?? UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontManager.getAppFont(size: .m3, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = FontManager.getAppFont(size: .m3, weight: .regular)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    init(providers: [(name: String, id: String)], selectedIndex: Int = 0) {
        self.providers = providers
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)

        self.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = self.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = false
                sheet.preferredCornerRadius = 16
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(containerView)
        containerView.addSubview(handleView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(tableView)
        containerView.addSubview(selectButton)
        containerView.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            handleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            handleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 40),
            handleView.heightAnchor.constraint(equalToConstant: 5),

            titleLabel.topAnchor.constraint(equalTo: handleView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(providers.count * 60)),

            selectButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            selectButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            selectButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            selectButton.heightAnchor.constraint(equalToConstant: 50),

            cancelButton.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 12),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func selectButtonTapped() {
        let selectedProvider = providers[selectedIndex]
        delegate?.didSelectProvider(name: selectedProvider.name, providerId: selectedProvider.id, index: selectedIndex)
        dismiss(animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewProviderSelector: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCell", for: indexPath) as! ProviderCell
        let provider = providers[indexPath.row]
        cell.configure(with: provider.name, isSelected: indexPath.row == selectedIndex)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndex = selectedIndex
        selectedIndex = indexPath.row

        tableView.reloadRows(at: [IndexPath(row: previousIndex, section: 0), indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - ProviderCell
class ProviderCell: UITableViewCell {

    private lazy var providerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.getAppFont(size: .m3, weight: .regular)
        return label
    }()

    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.globalColor ?? UIColor.systemBlue
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "checkmark.circle.fill")
        }
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(providerLabel)
        contentView.addSubview(checkmarkImageView)

        NSLayoutConstraint.activate([
            providerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            providerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(with providerName: String, isSelected: Bool) {
        providerLabel.text = providerName
        checkmarkImageView.isHidden = !isSelected
    }
}
