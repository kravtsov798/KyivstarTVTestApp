//
//  PromotionPageProvider.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import Combine

protocol PromotionPageProvider {
    var currentPagePublisher: AnyPublisher<Int, Never> { get }
    var totalPagesPublisher: AnyPublisher<Int, Never> { get }
    func save(subscription: AnyCancellable)
}
