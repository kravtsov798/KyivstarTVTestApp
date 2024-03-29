//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Combine
import Foundation

final class HomeViewModel: HomeRepresentable {
    var sectionPublisher: AnyPublisher<[HomeSection], Error> {
        sectionSubject.eraseToAnyPublisher()
    }
    let footerViewModel: HomeFooterViewRepresentable
    
    private let sectionSubject = PassthroughSubject<[HomeSection], Error>()
    private var sections: [HomeSection] = []
    private let apiService: ApiServicing
    private let assetDetailsPresenter: AssetDetailsScreenPresenter
    
    init(apiService: ApiServicing,
         assetDetailsPresenter: AssetDetailsScreenPresenter,
         footerViewModel: HomeFooterViewRepresentable = HomeFooterViewModel()) {
        self.apiService = apiService
        self.assetDetailsPresenter = assetDetailsPresenter
        self.footerViewModel = footerViewModel
    }
    
    func prepareSections() {
        Task {
            do {
                sections = try await withThrowingTaskGroup(of: [HomeSection].self, body: { [weak self] taskGroup in
                    guard let self else { return [HomeSection]() }
                    
                    taskGroup.addTask { try await self.preparePromotionsSection() }
                    taskGroup.addTask { try await self.prepareCategoriesSection() }
                    taskGroup.addTask { try await self.prepareContentGroupsSections() }
                    
                    var collected: [HomeSection] = []
                    for try await result in taskGroup {
                        collected.append(contentsOf: result)
                    }
                    return collected
                })
                
                sections.sort { $0.type.rawValue < $1.type.rawValue }
                
                // for skeletons demonstration
                try await Task.sleep(nanoseconds: Constants.taskSleepNanoseconds)
                
                sectionSubject.send(sections)
            } catch {
                sectionSubject.send(completion: .failure(error))
            }
        }
    }
    
    func openAssetDetails() {
        assetDetailsPresenter.openAssetDetails()
    }
    
    func removeSection(by id: UUID) {
        sections.removeAll { $0.id == id }
        sectionSubject.send(sections)
    }
    
    func getSection(by index: Int) -> HomeSection? {
        guard sections.indices.contains(index) else { return nil }
        return sections[index]
    }
}

extension HomeViewModel {
    private typealias Factory = HomeSectionFactory
    
    private func preparePromotionsSection() async throws -> [HomeSection] {
        let promotions = try await fetchPromotions()
        let section = Factory.createPromotionsSection(from: promotions)
        return [section]
    }
    
    private func fetchPromotions() async throws -> [Promotion] {
        let promotions = try await apiService.fetchPromotions()
        let promotionsCount = promotions.count
        footerViewModel.totalPagesSubject.send(promotionsCount)
        return promotions
    }
    
    private func prepareCategoriesSection() async throws -> [HomeSection] {
        let categories = try await apiService.fetchCategories()
        let section = Factory.createCategoriesSection(from: categories)
        return [section]
    }
    
    private func prepareContentGroupsSections() async throws -> [HomeSection] {
        let contentGroups = try await apiService.fetchContentGroups()
        let sections: [HomeSection] = contentGroups.compactMap {
            guard let groupType = $0.getParsedType() else { return nil }
            let sectionType = HomeSectionType.type(from: groupType)
            return Factory.createAssetsSection(from: $0, type: sectionType)
        }
        return sections
    }
}

extension HomeViewModel {
    private enum Constants {
        static let taskSleepNanoseconds: UInt64 = 2000000000
    }
}
