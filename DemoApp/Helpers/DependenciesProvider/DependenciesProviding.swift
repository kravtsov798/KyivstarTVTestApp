//
//  DependenciesProviding.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import UIKit

protocol DependenciesProviding {
    static func createAppCoordinator(with window: UIWindow) -> Coordinator
    static func createApiService() -> ApiServicing
}
