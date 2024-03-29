//
//  HomeFooterViewModel.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import Combine
import UIKit

class HomeFooterViewModel: HomeFooterViewRepresentable {
    var currentPagePublisher: AnyPublisher<Int, Never> {
        currentPageSubject.eraseToAnyPublisher()
    }
    var totalPagesPublisher: AnyPublisher<Int, Never> {
        totalPagesSubject.eraseToAnyPublisher()
    }
    let totalPagesSubject = CurrentValueSubject<Int, Never>(0)
    
    private let currentPageSubject = CurrentValueSubject<Int, Never>(0)
    private var subscriptions: Set<AnyCancellable> = []
    
    func calculatePageNumber(from xOffset: CGFloat, containerWidth: CGFloat) {
        let currentPage = Int(max(0, round(xOffset / containerWidth)))
        currentPageSubject.send(currentPage)
    }
    
    func save(subscription: AnyCancellable) {
        subscriptions.insert(subscription)
    }
}
