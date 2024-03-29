//
//  Promotion.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

struct Promotion: Identifiable, Codable {
    var id: String
    var name: String
    var image: URL
    var company: String
    var updatedAt: String
    var releaseDate: String
}
