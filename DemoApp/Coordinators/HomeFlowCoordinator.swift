//
//  HomeCoordinator.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 29.03.2024.
//

import UIKit

final class HomeFlowCoordinator: Coordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showHomeScreen()
    }
}

extension HomeFlowCoordinator {
    func showHomeScreen() {
        let apiService = DependenciesProvider.createApiService()
        let viewModel = HomeViewModel(apiService: apiService,
                                      assetDetailsPresenter: self)
        let dataSource = HomeCollectionDataSource(sectionProvider: viewModel)
        let layoutConfigurator = HomeCollectionViewLayoutConfigurator(
            sectionProvider: viewModel
        )
        
        let homeViewController = HomeViewController(viewModel: viewModel,
                                                    dataSource: dataSource,
                                                    layoutConfigurator: layoutConfigurator)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension HomeFlowCoordinator: AssetDetailsScreenPresenter {
    func openAssetDetails() {
        let apiService = DependenciesProvider.createApiService()
        let viewModel = AssetDetailsViewModel(apiService: apiService)
        let viewController = AssetDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
