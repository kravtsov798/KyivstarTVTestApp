//
//  BlueGradientProgressBar.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import GradientProgressBar
import UIKit

final class BlueGradientProgressBar: GradientProgressBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gradientColors = [
            .progressBarFirstGradient ?? .blue,
            .progressBarSecondGradient ?? .blue
        ]
        backgroundColor = .progressBarBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAndSet(progress: Float) {
        guard progress > 0 else { return }
        isHidden = false
        self.progress = progress
    }
    
    func hideAndResetProgressBar() {
        isHidden = true
        progress = 0
    }
}
