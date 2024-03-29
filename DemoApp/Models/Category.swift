//
//  Category.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

struct Category: Identifiable, Codable {
    var id: String
    var name: String
    var image: URL
}
