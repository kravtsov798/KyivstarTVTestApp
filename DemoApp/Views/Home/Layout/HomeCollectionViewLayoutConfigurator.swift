//
//  HomeCollectionViewConfigurator.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import UIKit

final class HomeCollectionViewLayoutConfigurator: CollectionViewLayoutConfigurator {
    private typealias Factory = HomeCollectionViewLayoutFactory
    private var sectionProvider: HomeSectionProviding?
    
    init(sectionProvider: HomeSectionProviding?) {
        self.sectionProvider = sectionProvider
    }
    
    @MainActor
    func configureLayout(visiblePromotionsInvalidationHandler handler: @escaping Handler) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let self,
                  let sectionProvider = self.sectionProvider,
                  let sectionType = sectionProvider.getSection(by: sectionIndex)?.type
            else {
                return nil
            }
        
            switch sectionType {
            case .promotion:
                let section = Factory.createPromotionsSectionLayout()
                section.visibleItemsInvalidationHandler = { _, contentOffset, environment in
                    handler(contentOffset.x, environment.container.contentSize.width)
                }
                return section
            case .categories: return Factory.createCategoriesSectionLayout()
            case .movieSeries: return Factory.createMovieSeriesSectionLayout()
            case .liveChannel: return Factory.createLiveChannelSectionLayout()
            case .epg: return Factory.createEPGSectionLayout()
            }
        }
        
        return layout
    }
}
