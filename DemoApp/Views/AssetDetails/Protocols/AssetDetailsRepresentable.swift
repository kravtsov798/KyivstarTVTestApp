//
//  AssetDetailsRepresentable.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import Foundation

protocol AssetDetailsRepresentable: ObservableObject {
    var name: String { get }
    var description: String { get }
    var info: String? { get }
    var imageURL: URL? { get }
    var similarAssets: [Asset] { get }
    var isFavorite: Bool { get }
    var errorMessage: String? { get }
    var showSkeleton: Bool { get }
    
    func fetchAssetDetails() async
    func playButtonTapped()
    func favoriteButtonTapped()
    func dismissErrorTapped()
}
