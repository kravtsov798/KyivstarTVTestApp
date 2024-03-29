//
//  HomeSectionProviding.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import Foundation

protocol HomeSectionProviding {
    func getSection(by index: Int) -> HomeSection?
    func removeSection(by id: UUID)
}
