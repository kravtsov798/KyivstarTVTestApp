//
//  EPGCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class EPGCell: BaseCell {
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let vStack = UIStackView()
    private let labelsVStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func setup(withImage image: URL, showLockImage: Bool, name: String, description: String, progress: Float) {
        setup(withImage: image)
        lockImageView.isHidden = !showLockImage
        nameLabel.text = name
        descriptionLabel.text = description
        progressBar.showAndSet(progress: progress)
    }
    
    override func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight)
        ])
    }
    
    override func setupLockImageViewConstraints() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: imageView.topAnchor,
                                               constant: Constants.LockImage.offset),
            lockImageView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,
                                                   constant: Constants.LockImage.offset),
            lockImageView.heightAnchor.constraint(equalToConstant: Constants.LockImage.size),
            lockImageView.widthAnchor.constraint(equalToConstant: Constants.LockImage.size)
        ])
    }
}

extension EPGCell {
    private func setupSubviews() {
        setupVStack()
        setupLabelsVStack()
        setupNameLabel()
        setupDescriptionLabel()
        
        imageViewCornerRadius = Constants.imageCornerRadius
        
        lockImageView.removeFromSuperview()
        imageView.addSubview(lockImageView)
    }
    
    private func setupSubviewsConstraints() {
        setupImageViewConstraints()
        setupVStackConstraints()
        setupLockImageViewConstraints()
    }
    
    //MARK: stacks
    private func setupVStack() {
        contentView.addSubview(vStack)
        vStack.axis = .vertical
        vStack.spacing = Constants.vStackSpacing
        vStack.addArrangedSubview(imageView)
    }
    
    private func setupVStackConstraints() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupLabelsVStack() {
        vStack.addArrangedSubview(labelsVStack)
        labelsVStack.axis = .vertical
        labelsVStack.distribution = .fillEqually
        labelsVStack.alignment = .leading
    }

    //MARK: labels
    private func setupNameLabel() {
        labelsVStack.addArrangedSubview(nameLabel)
        nameLabel.textColor = .assetNameTextBlack
        nameLabel.font = .systemFont(ofSize: Constants.nameLabelFontSize)
    }
    
    private func setupDescriptionLabel() {
        labelsVStack.addArrangedSubview(descriptionLabel)
        descriptionLabel.textColor = .assetDescriptionTextGray
        descriptionLabel.font = .systemFont(ofSize: Constants.descriptionLabelFontSize)
    }
}

extension EPGCell {
    private enum Constants {
        static let vStackSpacing: CGFloat = 7
        static let imageViewHeight: CGFloat = 123
        static let imageCornerRadius: CGFloat = 12

        static let nameLabelFontSize: CGFloat = 12
        static let descriptionLabelFontSize: CGFloat = 11
        
        enum LockImage {
            static let size: CGFloat = 24
            static let name = "lock"
            static let offset: CGFloat = 8
        }
    }
}
