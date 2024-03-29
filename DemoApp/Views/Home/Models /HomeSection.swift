//
//  HomeSection.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import Foundation

struct HomeSection: Identifiable, Hashable {
    let id = UUID()
    let type: HomeSectionType
    let name: String
    let canBeDeleted: Bool
    
    let items: [HomeCell]
}


