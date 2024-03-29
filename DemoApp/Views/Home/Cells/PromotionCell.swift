//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class PromotionCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        setupImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with url: URL) {
        setup(withImage: url)
    }
    
    override func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: Constants.imageHorizontalOffset
            ),
            imageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -Constants.imageHorizontalOffset
            ),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
}

extension PromotionCell {
    private enum Constants {
        static let imageHeight: CGFloat = 180
        static let imageHorizontalOffset: CGFloat = 24
    }
}
