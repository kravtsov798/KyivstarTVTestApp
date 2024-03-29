//
//  HomeSectionType.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 25.03.2024.
//

import Foundation

enum HomeSectionType: Int {
    case promotion
    case categories
    case movieSeries
    case liveChannel
    case epg
}

extension HomeSectionType {
    static func type(from groupType: ContentGroup.GroupType) -> Self {
        switch groupType {
        case .movie, .series: return .movieSeries
        case .liveChannel: return .liveChannel
        case .epg: return .epg
        }
    }
}
