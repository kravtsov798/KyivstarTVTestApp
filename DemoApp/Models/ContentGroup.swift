//
//  ContentGroup.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

struct ContentGroup: Identifiable, Codable {
    var id: String
    var name: String
    var type: [String]
    var assets: [Asset]
    var hidden: Bool
    var sortIndex: Int
    var canBeDeleted: Bool
}

extension ContentGroup {
    func getParsedType() -> GroupType? {
        guard let type = type.first,
              let parsedType = GroupType(rawValue: type.lowercased())
        else {
            return nil
        }
        return parsedType
    }
    
    enum GroupType: String {
        case movie = "movie"
        case series = "series"
        case liveChannel = "livechannel"
        case epg = "epg"
    }
}
