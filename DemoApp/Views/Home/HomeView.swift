//
//  HomeView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import UIKit

final class HomeView: UIView {
    private(set) lazy var collectionView: UICollectionView! = nil
    
    private let layoutConfigurator: CollectionViewLayoutConfigurator
    private let pageCalculator: PromotionPageCalculator
    
    init(layoutConfigurator: CollectionViewLayoutConfigurator,
         pageCalculator: PromotionPageCalculator) {
        self.layoutConfigurator = layoutConfigurator
        self.pageCalculator = pageCalculator
        super.init(frame: .zero)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = layoutConfigurator.configureLayout {
            [weak self] promotionXOffset, promotionsContainerWidth in
            self?.pageCalculator.calculatePageNumber(from: promotionXOffset,
                                                     containerWidth: promotionsContainerWidth)
        }
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        registerCollectionViewCells()
        addSubview(collectionView)
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(PromotionCell.self,
                                forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.register(LiveChannelCell.self,
                                forCellWithReuseIdentifier: LiveChannelCell.reuseIdentifier)
        collectionView.register(AssetCell.self,
                                forCellWithReuseIdentifier: AssetCell.reuseIdentifier)
        collectionView.register(EPGCell.self,
                                forCellWithReuseIdentifier: EPGCell.reuseIdentifier)
        collectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: HomeHeaderView.viewKind,
                                withReuseIdentifier: HomeHeaderView.reuseIdentifier)
        collectionView.register(HomeFooterView.self,
                                forSupplementaryViewOfKind: HomeFooterView.viewKind,
                                withReuseIdentifier: HomeFooterView.reuseIdentifier)
    }
}
