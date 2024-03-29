//
//  AssetDetailsViewModel.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

final class AssetDetailsViewModel: AssetDetailsRepresentable {
    @Published var name = ""
    @Published var description: String = ""
    @Published var info: String?
    @Published var imageURL: URL?
    @Published var similarAssets: [Asset] = []
    @Published var isFavorite = false
    @Published var errorMessage: String?
    @Published var showSkeleton: Bool = true
    
    private let apiService: ApiServicing
    
    init(apiService: ApiServicing) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchAssetDetails() async {
        do {
            let details = try await apiService.fetchAssetDetails()
            
            // for skeletons demonstrations
            try await Task.sleep(nanoseconds: Constants.taskSleepNanoseconds)
            
            fillProperties(with: details)
            showSkeleton = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func playButtonTapped() {
        print("Play button tapped")
    }
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
    }
    
    func dismissErrorTapped() {
        errorMessage = nil
    }
}

extension AssetDetailsViewModel {
    private func fillProperties(with details: AssetDetails) {
        imageURL = details.image
        similarAssets = details.similar
        name = details.name.isEmpty ? Constants.defaultDetailsName : details.name
        description = details.description
        info = configureAssetInfo(from: details)
    }
    
    private func configureAssetInfo(from details: AssetDetails) -> String? {
        var info: [String?] = []
        
        info.append(getDurationString(from: details.duration))
        info.append(getReleaseYearString(from: details.releaseDate))
        
        let infoStr = info.compactMap { $0 }.joined(separator: Constants.infoComponentsSeparator)
        return infoStr
    }
    
    private func getDurationString(from duration: Int) -> String? {
        guard duration > 0 else { return nil }
        
        var minutes = duration / 60
        let hourse = minutes / 60
        minutes = minutes % 60
        
        return hourse > 0 ? "\(hourse)h \(minutes)m" : "\(minutes)m"
    }
    
    private func getReleaseYearString(from releaseData: String) -> String? {
        guard !releaseData.isEmpty else { return nil }
        return releaseData.components(separatedBy: Constants.dateSeparator).first
    }
}

extension AssetDetailsViewModel {
    private enum Constants {
        static let defaultDetailsName = "Unnamed"
        static let infoComponentsSeparator = " • "
        static let dateSeparator = "-"
        static let taskSleepNanoseconds: UInt64 = 2000000000
    }
}

