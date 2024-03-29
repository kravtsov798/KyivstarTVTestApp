//
//  Asset.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

struct Asset: Identifiable, Hashable, Codable {
    var id: String
    var name: String
    var image: URL
    var company: String
    var progress: Int
    var purchased: Bool
    var updatedAt: String
    var releaseDate: String
}
