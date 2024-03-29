//
//  HeaderView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView {
    static let viewKind = HomeSupplementaryViewKind.header.rawValue
    
    private let titleLabel = UILabel()
    private let deleteButton = UIButton()
    private var deleteAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupDeleteButton()
        
        setupTitleLabelConstraints()
        setupDeteleButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        deleteButton.isHidden = true
    }
    
    func setup(with title: String, showDeleteButton: Bool, deleteAction: @escaping () -> Void) {
        titleLabel.text = title
        deleteButton.isHidden = !showDeleteButton
        self.deleteAction = deleteAction
    }
}

extension HomeHeaderView {
    //MARK: titleLabel
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .robotoFont(ofSize: Constants.fontSize)
        titleLabel.textColor = .sectionTitleBlack
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight)
        ])
    }
    
    //MARK: deleteButton
    private func setupDeleteButton() {
        addSubview(deleteButton)
        deleteButton.setTitle(Constants.deleteButtonTitle, for: .normal)
        deleteButton.titleLabel?.font = .robotoFont(ofSize: Constants.fontSize) ?? .systemFont(ofSize: Constants.fontSize)
        
        deleteButton.setTitleColor(.blueButton, for: .normal)
        deleteButton.setTitleColor(.blueButtonTapped, for: .highlighted)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    private func setupDeteleButtonConstraints() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: Constants.deleteButtonHeight)
        ])
    }
    
    @objc private func deleteButtonTapped() {
        deleteAction?()
    }
}

extension HomeHeaderView {
    private enum Constants {
        static let fontSize: CGFloat = 16
        static let titleHeight: CGFloat = 24
        
        static let deleteButtonTitle = "Del"
        static let deleteButtonHeight: CGFloat = 24
    }
}
