//
//  HomeCell.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import Foundation

struct HomeCell: Hashable {
    let image: URL
    let name: String
    let isPurchased: Bool?
    let description: String?
    let progress: Int?
    
    init(image: URL, name: String, isPurchased: Bool? = nil , description: String? = nil, progress: Int? = nil) {
        self.image = image
        self.name = name
        self.isPurchased = isPurchased
        self.description = description
        self.progress = progress
    }
}
