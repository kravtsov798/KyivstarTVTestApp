//
//  AppCoordinator.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import UIKit

final class AppCoordinator: Coordinator  {
    private let window: UIWindow
    private let homeFlowCoordinator: Coordinator
    
    init(window: UIWindow) {
        self.window = window
        homeFlowCoordinator = DependenciesProvider.createHomeFlowCoordinator(with: window)
    }
    
    func start() {
        startHomeFlow()
    }
}

extension AppCoordinator {
    private func startHomeFlow() {
        homeFlowCoordinator.start()
    }
}
