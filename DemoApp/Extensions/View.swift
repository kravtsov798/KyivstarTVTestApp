//
//  View.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import SwiftUI
import UIKit

extension View {
    func injectIn(controller vc: UIViewController) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        vc.view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            controller.view.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor),
            controller.view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor)
        ])
    }
    
    func injectIn(view: UIView) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
