//
//  HomeRepresentable.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 27.03.2024.
//

import Combine
import Foundation

protocol HomeRepresentable: HomeSectionProviding {
    var sectionPublisher: AnyPublisher<[HomeSection], Error> { get }
    var footerViewModel: HomeFooterViewRepresentable { get }
    
    func prepareSections()
    func openAssetDetails()
}
