//
//  CategoryCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class CategoryCell: BaseCell {
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameLabel()
        
        setupImageViewConstraints()
        setupNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    func setup(withImage image: URL, name: String) {
        setup(withImage: image)
        nameLabel.text = name
    }
    
    override func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}

extension CategoryCell {
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.textColor = .assetNameTextBlack
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: Constants.nameFontSize)
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                           constant: Constants.nameLabelTopOffset)
        ])
    }
}

extension CategoryCell {
    private enum Constants {
        static let nameFontSize: CGFloat = 12
        static let nameLabelTopOffset: CGFloat = 8
    }
}
