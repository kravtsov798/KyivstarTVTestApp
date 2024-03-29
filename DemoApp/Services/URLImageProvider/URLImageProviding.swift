//
//  URLImageProviding.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import UIKit

protocol URLImageProviding {
    @MainActor
    func fetchImage(by url: URL) async throws -> UIImage
}

