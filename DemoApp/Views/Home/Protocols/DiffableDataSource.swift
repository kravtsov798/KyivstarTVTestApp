//
//  DiffableDataSource.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import UIKit

protocol DiffableDataSource {
    associatedtype SectionIdentifierType: Hashable
    associatedtype ItemIdentifierType: Hashable
    
    func configure(for collectionView: UICollectionView)
    func configureSupplementaryViews(with pageProvider: PromotionPageProvider)
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>)
}
