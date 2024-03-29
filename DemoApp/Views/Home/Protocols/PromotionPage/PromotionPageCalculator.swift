//
//  PromotionPageCalculator.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import Foundation

protocol PromotionPageCalculator {
    func calculatePageNumber(from xOffset: CGFloat, containerWidth: CGFloat)
}
