//
//  ApiService.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

import Alamofire
import Foundation

final class ApiService: NetworkService, ApiServicing  {
    func fetchContentGroups() async throws -> [ContentGroup] {
        try await request(url: ApiEndpoint.fetchContentGroups.url, headers: httpHeadersWithToken)
    }
    
    func fetchPromotions() async throws -> [Promotion] {
        let promotionsData: PromotionsData = try await request(
            url: ApiEndpoint.fetchPromotions.url, headers: httpHeadersWithToken
        )
        return promotionsData.promotions
    }
    
    func fetchCategories() async throws -> [Category] {
        let list: CategoryList = try await request(
            url: ApiEndpoint.fetchCategories.url, headers: httpHeadersWithToken
        )
        return list.categories
    }
    
    func fetchAssetDetails() async throws -> AssetDetails {
        try await request(url: ApiEndpoint.fetchAssetDetails.url, headers: httpHeadersWithToken)
    }
}

extension ApiService {
    private var httpHeadersWithToken:  HTTPHeaders {
        return ["Authorization": "Bearer vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"]
    }
}
