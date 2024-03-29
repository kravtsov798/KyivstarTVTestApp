//
//  HomeSkeletonContainer.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import UIKit
import SwiftUI

final class HomeViewSkeletonContainer: UIView {
    private let skeleton = HomeViewSkeleton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        skeleton.injectIn(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
