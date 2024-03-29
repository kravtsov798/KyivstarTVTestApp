//
//  HomeFooterViewRepresentable.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import Combine

protocol HomeFooterViewRepresentable: PromotionPageCalculator, PromotionPageProvider {
    var totalPagesSubject: CurrentValueSubject<Int, Never> { get }
}
