//
//  ViewController.swift
//  DemoApp
//
//  Created by Pete Shpagin on 31.03.2021.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {
    private let logoImageView = UIImageView()
    private let contentView: HomeView
    private let skeleton = HomeViewSkeletonContainer()
    
    private let viewModel: HomeRepresentable
    private let dataSource: HomeCollectionDataSource
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: HomeRepresentable,
         dataSource: HomeCollectionDataSource,
         layoutConfigurator: CollectionViewLayoutConfigurator) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        self.contentView = HomeView(layoutConfigurator: layoutConfigurator,
                                    pageCalculator: viewModel.footerViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
        contentView.collectionView.delegate = self
        contentView.addSubview(skeleton)
        setupSkeletonConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationElements()
        
        setupDataSource()
        subscribeOnSectionsPublisher()
        
        viewModel.prepareSections()
    }
    
    //MARK: navigationElements
    private func configureNavigationElements() {
        setupLogoImageView()
        navigationItem.titleView = logoImageView
        navigationItem.title = Constants.navigationTitle
        navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupLogoImageView() {
        let image = UIImage(named: Constants.logoImageName)
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFit
    }
    
    //MARK: skeleton
    private func setupSkeletonConstraints() {
        skeleton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeleton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skeleton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            skeleton.topAnchor.constraint(equalTo: contentView.topAnchor),
            skeleton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    private func hideSkeleton() {
        skeleton.removeFromSuperview()
    }
    
    private func setupDataSource() {
        dataSource.configure(for: contentView.collectionView)
        dataSource.configureSupplementaryViews(with: viewModel.footerViewModel)
    }
    
    private func subscribeOnSectionsPublisher() {
        viewModel.sectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] sections in
                self?.configureSnapshot(with: sections)
                self?.hideSkeleton()
            }
            .store(in: &subscriptions)
    }
    
    private func configureSnapshot(with sections: [HomeSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection.ID, HomeCell>()
        snapshot.appendSections(sections.map { $0.id })
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0.id)
        }
        dataSource.apply(snapshot)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        guard case let .failure(error) = completion else { return }
        
        let alertViewController = buildAlert(with: error)
        present(alertViewController, animated: true)
    }
    
    private func buildAlert(with error: Error) -> UIAlertController {
        return AlertBuilder()
            .setStyle(.alert)
            .addTitle(Constants.alertTitle)
            .addMessage(error.localizedDescription)
            .addAction(with: Constants.alertButtonText,
                       actionStyle: .cancel,
                       handler: {_ in })
            .build()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.openAssetDetails()
    }
}

extension HomeViewController {
    private enum Constants {
        static let navigationTitle = "Home"
        static let logoImageName = "logo"
        static let alertTitle = "Error!"
        static let alertButtonText = "OK"
    }
}
