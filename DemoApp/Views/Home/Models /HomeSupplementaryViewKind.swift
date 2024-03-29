//
//  HomeSupplementaryViewKind.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 28.03.2024.
//

import UIKit

enum HomeSupplementaryViewKind: String {
    case header = "homeCollectionHeader"
    case footer = "homeCollectionFooter"
}

extension HomeSupplementaryViewKind {
    static func kind(from value: String) -> Self? {
        switch value {
        case HomeSupplementaryViewKind.header.rawValue: return .header
        case HomeSupplementaryViewKind.footer.rawValue: return .footer
        default: return nil
        }
    }
}
