//
//  ApiEndpoint.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

enum ApiEndpoint{
    case fetchPromotions
    case fetchCategories
    case fetchContentGroups
    case fetchAssetDetails
    
    var url: URL {
        baseUrl.appendingPathComponent(path)
    }
}

extension ApiEndpoint {
    private var baseUrl: URL {
        URL(string: "https://api.json-generator.com/templates")!
    }
    
    private var path: String {
        switch self {
        case .fetchPromotions:
            return "j_BRMrbcY-5W/data"
        case .fetchCategories:
            return "eO-fawoGqaNB/data"
        case .fetchContentGroups:
            return "PGgg02gplft-/data"
        case .fetchAssetDetails:
            return "04Pl5AYhO6-n/data"
        }
    }
}
