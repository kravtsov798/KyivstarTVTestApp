//
//  ApiServicing.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

protocol ApiServicing {
    func fetchContentGroups() async throws -> [ContentGroup]
    func fetchPromotions() async throws -> [Promotion]
    func fetchCategories() async throws -> [Category]
    func fetchAssetDetails() async throws -> AssetDetails
}
