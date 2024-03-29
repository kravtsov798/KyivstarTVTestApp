//
//  Skeleton.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import SwiftUI

struct Skeleton: View {
    @State var startPoint: UnitPoint = .topLeading
    @State var endPoint: UnitPoint = .bottomTrailing
    
    var gradient: [Color] = [
        .gray,
        .lightGray
    ]
    
    private var gradientFill: LinearGradient {
        LinearGradient(gradient: Gradient(colors: gradient),
                       startPoint: startPoint,
                       endPoint: endPoint)
    }
    
    var body: some View {
        Rectangle()
            .fill(gradientFill)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    startPoint = .center
                }
            }
    }
}

struct Skeleton_Previews: PreviewProvider {
    static var previews: some View {
        Skeleton(gradient: [
            .progressBarFirstGradient,
            .progressBarSecondGradient
        ])
        .frame(width: 104, height: 156)
    }
}
