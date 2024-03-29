//
//  ImageCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import AlamofireImage
import UIKit

class BaseCell: UICollectionViewCell {
    let imageView = UIImageView()
    let progressBar = BlueGradientProgressBar()
    let lockImageView = UIImageView()
    
    var imageViewCornerRadius = Constants.defaultImageViewCornerRadius {
        didSet { imageView.layer.cornerRadius = imageViewCornerRadius }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setupImageView()
        setupProgressBar()
        setupLockImageView()
        
        setupImageViewConstraints()
        setupProgressBarConstraints()
        setupLockImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: Constants.placeholderName)
        progressBar.hideAndResetProgressBar()
        lockImageView.isHidden = true
    }
    
    func setup(withImage image: URL) {
        imageView.af.setImage(
            withURL: image, placeholderImage: UIImage(named: Constants.placeholderName)
        )
    }
    
    func setupImageView() {
        imageView.layer.cornerRadius = imageViewCornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupLockImageView() {
        contentView.addSubview(lockImageView)
        lockImageView.image = UIImage(named: Constants.LockImage.name)
        lockImageView.clipsToBounds = true
        lockImageView.isHidden = true
    }
    
    func setupLockImageViewConstraints() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.LockImage.offset),
            lockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constants.LockImage.offset),
            lockImageView.heightAnchor.constraint(equalToConstant: Constants.LockImage.size),
            lockImageView.widthAnchor.constraint(equalToConstant: Constants.LockImage.size)
        ])
    }
}

extension BaseCell {
    private func setupProgressBar() {
        imageView.addSubview(progressBar)
        progressBar.hideAndResetProgressBar()
    }
    
    private func setupProgressBarConstraints() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            progressBar.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: Constants.progressBarHeight)
        ])
    }
}

extension BaseCell {
    private enum Constants {
        static let progressBarHeight: CGFloat = 4
        static let placeholderName = "imagePlaceholder"
        static let defaultImageViewCornerRadius: CGFloat = 16
        
        enum LockImage {
            static let size: CGFloat = 24
            static let name = "lock"
            static let offset: CGFloat = 8
        }
    }
}
