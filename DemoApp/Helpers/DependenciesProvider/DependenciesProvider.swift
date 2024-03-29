//
//  DependenciesProvider.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import UIKit

final class DependenciesProvider: DependenciesProviding {
    static func createAppCoordinator(with window: UIWindow) -> Coordinator {
        return AppCoordinator(window: window)
    }
    
    static func createHomeFlowCoordinator(with window: UIWindow) -> Coordinator {
        return HomeFlowCoordinator(window: window)
    }
    
    static func createApiService() -> ApiServicing {
        return ApiService()
    }
}
