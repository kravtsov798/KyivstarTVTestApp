//
//  BorderedButtonStyle.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    let borderColor: Color
    let shadowColor: Color
    let pressedColor: Color
    
    init(width: CGFloat, height: CGFloat, color: Color,
         borderColor: Color, shadowColor: Color, pressedColor: Color? = nil) {
        self.width = width
        self.height = height
        self.color = color
        self.borderColor = borderColor
        self.shadowColor = shadowColor
        self.pressedColor = pressedColor ?? color
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .background(backgroundCapsule(isPressed: configuration.isPressed))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension BorderedButtonStyle {
    private func backgroundCapsule(isPressed: Bool) -> some View {
        ZStack {
            Capsule()
                .foregroundColor(borderColor)
                .shadow(color: shadowColor, radius: 0, x: 0, y: 1)
            Capsule()
                .inset(by: 1)
                .foregroundColor(isPressed ? pressedColor : color)
        }
    }
}
