//
//  HomeSectionFactory.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import UIKit

final class HomeSectionFactory {
    static func createPromotionsSection(from promotions: [Promotion]) -> HomeSection {
        let items = promotions.map { HomeCell(image: $0.image, name: $0.name) }
        let section = HomeSection(type: .promotion, name: "", canBeDeleted: false, items: items)
        return section
    }
    
    static func createCategoriesSection(from categories: [Category]) -> HomeSection {
        let items = categories.map { HomeCell(image: $0.image, name: $0.name) }
        let section = HomeSection(type: .categories, name: "", canBeDeleted: false, items: items)
        return section
    }
    
    static func createAssetsSection(from group: ContentGroup, type: HomeSectionType) -> HomeSection {
        let items = group.assets.map {
            HomeCell(image: $0.image,
                     name: $0.name,
                     isPurchased: $0.purchased,
                     description: $0.company,
                     progress: $0.progress)
        }
        let section = HomeSection(
            type: type, name: group.name, canBeDeleted: group.canBeDeleted, items: items
        )
        return section
    }
}
