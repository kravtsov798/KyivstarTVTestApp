//
//  HomeCollectionDataSource.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 26.03.2024.
//

import Combine
import UIKit

final class HomeCollectionDataSource: DiffableDataSource {
    private typealias DataSource = UICollectionViewDiffableDataSource<HomeSection.ID, HomeCell>
    
    private var dataSource: DataSource?
    private weak var collectionView: UICollectionView?
    private let sectionProvider: HomeSectionProviding
    
    init(sectionProvider: HomeSectionProviding) {
        self.sectionProvider = sectionProvider
    }
    
    func configure(for collectionView: UICollectionView) {
        self.collectionView = collectionView
        setupDataSource()
    }
    
    func configureSupplementaryViews(with pageProvider: PromotionPageProvider) {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let section = self?.sectionProvider.getSection(by: indexPath.section),
                  let kind = HomeSupplementaryViewKind.kind(from: kind)
            else {
                return UICollectionReusableView()
            }
            
            switch kind {
            case .header:
                return self?.setupHeader(for: section, at: indexPath)
            case .footer:
                return self?.setupFooter(with: pageProvider, for: section, at: indexPath)
            }
        }
    }
    
    func apply(_ snapshot: NSDiffableDataSourceSnapshot<HomeSection.ID, HomeCell>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeCollectionDataSource {
    private func setupDataSource() {
        guard let collectionView else { return }
        dataSource = DataSource(collectionView: collectionView) {
            [weak self] (collectionView, indexPath, cellItem) -> UICollectionViewCell? in
            
            guard let sectionType = self?.sectionProvider.getSection(by: indexPath.section)?.type
            else { return nil }
            
            switch sectionType {
            case .promotion: return self?.setupPromotionCell(by: indexPath, with: cellItem)
            case .categories: return self?.setupCategoryCell(by: indexPath, with: cellItem)
            case .movieSeries: return self?.setupMovieSeriesCell(by: indexPath, with: cellItem)
            case .liveChannel: return self?.setupLiveChannelCell(by: indexPath, with: cellItem)
            case .epg: return self?.setupEPGCell(by: indexPath, with: cellItem)
            }
        }
    }
    
    // MARK: cells
    private func setupPromotionCell(by indexPath: IndexPath,
                                    with cellItem: HomeCell) -> UICollectionViewCell {
        guard let cell: PromotionCell = dequeueCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(with: cellItem.image)
        return cell
    }
    
    private func setupCategoryCell(by indexPath: IndexPath,
                                   with cellItem: HomeCell) -> UICollectionViewCell {
        guard let cell: CategoryCell = dequeueCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(withImage: cellItem.image, name: cellItem.name)
        return cell
    }
    
    private func setupMovieSeriesCell(by indexPath: IndexPath,
                                      with cellItem: HomeCell) -> UICollectionViewCell {
        guard let cell: AssetCell = dequeueCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(withImage: cellItem.image,
                   name: cellItem.name,
                   showLockImage: !(cellItem.isPurchased ?? true),
                   progress: Float(cellItem.progress ?? 0) / 100.0)
        return cell
    }
    
    private func setupLiveChannelCell(by indexPath: IndexPath,
                                      with cellItem: HomeCell) -> UICollectionViewCell {
        guard let cell: LiveChannelCell = dequeueCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(withImage: cellItem.image, showLockImage: !(cellItem.isPurchased ?? true))
        return cell
    }
    
    private func setupEPGCell(by indexPath: IndexPath,
                              with cellItem: HomeCell) -> UICollectionViewCell {
        guard let cell: EPGCell = dequeueCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.setup(withImage: cellItem.image,
                   showLockImage: !(cellItem.isPurchased ?? true),
                   name: cellItem.name,
                   description: cellItem.description ?? "",
                   progress: Float(cellItem.progress ?? 0) / 100.0)
        return cell
    }
    
    //MARK: supplementeries
    private func setupHeader(for section: HomeSection, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header: HomeHeaderView = dequeueSupplementaryView(withKind: HomeHeaderView.viewKind,
                                                                    for: indexPath)
        else {
            return UICollectionReusableView()
        }
        
        let name = section.type == .categories ? Constants.categoriesSectionName : section.name
        header.setup(with: name,
                     showDeleteButton: section.canBeDeleted) { [weak self] in
            self?.sectionProvider.removeSection(by: section.id)
        }
        return header
    }
    
    private func setupFooter(with pageProvider: PromotionPageProvider, for section: HomeSection, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer: HomeFooterView = dequeueSupplementaryView(withKind: HomeFooterView.viewKind,
                                                                    for: indexPath)
        else {
            return UICollectionReusableView()
        }
        footer.setup(with: pageProvider)
        return footer
    }
    
    //MARK: dequeueViews
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell? {
        let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier,
                                                       for: indexPath) as? Cell
        return cell
    }
    
    private func dequeueSupplementaryView<View: UICollectionReusableView>(withKind kind: String,
                                                                  for indexPath: IndexPath) -> View? {
        let view = collectionView?.dequeueReusableSupplementaryView(ofKind: kind,
                                                                    withReuseIdentifier: View.reuseIdentifier,
                                                                    for: indexPath) as? View
        return view
    }
}

extension HomeCollectionDataSource {
    private enum Constants {
        static let categoriesSectionName = "Categories"
    }
}

