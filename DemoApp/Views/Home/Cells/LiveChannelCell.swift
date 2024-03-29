//
//  LiveChannelCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class LiveChannelCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLockImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = contentView.bounds.width / 2
    }
    
    override func setupImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func setup(withImage image: URL, showLockImage: Bool) {
        setup(withImage: image)
        lockImageView.isHidden = !showLockImage
    }
    
    override func setupLockImageViewConstraints() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lockImageView.heightAnchor.constraint(equalToConstant: Constants.lockImageViewSize),
            lockImageView.widthAnchor.constraint(equalToConstant: Constants.lockImageViewSize)
        ])
    }
}

extension LiveChannelCell {
    private enum Constants {
        static let lockImageViewSize: CGFloat = 32
    }
}
