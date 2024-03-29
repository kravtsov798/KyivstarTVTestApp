//
//  GradientProgressView.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import SwiftUI

struct GradientProgressView: View {
    let value: Float
    let total: Float
    let gradientColors: [Color]
    let backgroundColor: Color
    
    private var percentage: CGFloat {
        CGFloat(value / total)
    }

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Rectangle()
                    .foregroundColor(backgroundColor)
                Rectangle()
                    .fill(LinearGradient(colors: gradientColors,
                                         startPoint: .leading,
                                         endPoint: .trailing))
                    .foregroundColor(.blue)
                    .frame(width: proxy.size.width * percentage)
            }
        }
        .clipShape(Capsule(style: .continuous))
    }
}
struct GradientProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GradientProgressView(value: 70,
                             total: 100,
                             gradientColors: [.progressBarFirstGradient, .progressBarSecondGradient],
                             backgroundColor: .progressBarBackground)
        .frame(height: 4)
    }
}
