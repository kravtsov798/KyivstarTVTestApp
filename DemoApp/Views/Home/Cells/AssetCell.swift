//
//  AssetCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import UIKit

final class AssetCell: BaseCell {
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewCornerRadius = Constants.imageCornerRadius
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
    
    func setup(withImage image: URL,
               name: String,
               showLockImage: Bool, progress: Float) {
        super.setup(withImage: image)
        lockImageView.isHidden = !showLockImage
        nameLabel.text = name
        progressBar.showAndSet(progress: progress)
    }
    
    override func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight)
        ])
    }
}

extension AssetCell {
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.textColor = .assetNameTextBlack
        nameLabel.font = .systemFont(ofSize: Constants.nameLabelFontSize)
        nameLabel.numberOfLines = 0
    }
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                           constant: Constants.nameLabelTopSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

extension AssetCell {
    enum Constants {
        static let imageViewHeight: CGFloat = 156
        static let imageCornerRadius: CGFloat = 12
        
        static let nameLabelFontSize: CGFloat = 12
        static let nameLabelTopSpacing: CGFloat = 8
    }
}
