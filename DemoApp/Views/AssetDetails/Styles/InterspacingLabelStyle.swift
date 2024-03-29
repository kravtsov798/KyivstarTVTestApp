//
//  InterspacingLabelStyle.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import SwiftUI

struct InterspacingLabelStyle: LabelStyle {
    var spacing: CGFloat = 0.0
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}
