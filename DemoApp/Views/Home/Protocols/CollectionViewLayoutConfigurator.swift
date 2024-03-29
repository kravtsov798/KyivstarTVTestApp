//
//  CollectionViewLayoutConfigurator.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import Combine
import UIKit

protocol CollectionViewLayoutConfigurator {
    typealias Handler = (_ promotionXOffset: CGFloat,_ promotionsContainerWidth: CGFloat) -> Void
    func configureLayout(visiblePromotionsInvalidationHandler handler: @escaping Handler) -> UICollectionViewLayout
}
