//
//  AssetDetailsViewController.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import SwiftUI
import UIKit

final class AssetDetailsViewController<ViewModel: AssetDetailsRepresentable> : UIViewController {
    private let contentView: AssetDetailsView<ViewModel>
    
    init(viewModel: ViewModel) {
        contentView = AssetDetailsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        contentView.injectIn(controller: self)
        navigationItem.title = Constants.navigationTitle
    }
}

extension AssetDetailsViewController {
    private enum Constants {
        static var navigationTitle: String { "Asset Details" }
    }
}
