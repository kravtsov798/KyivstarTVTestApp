//
//  URLImageProvider.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Foundation

import Alamofire
import AlamofireImage
import UIKit

final class URLImageProvider: URLImageProviding {
    private let cache = AutoPurgingImageCache()
    
    @MainActor
    func fetchImage(by url: URL) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            if let image = cache.image(withIdentifier: url.absoluteString) {
                continuation.resume(returning: image)
            } else {
                AF.request(url)
                    .validate()
                    .responseImage { response in
                        if let image = response.value {
                            self.cache.add(image, withIdentifier: url.absoluteString)
                            continuation.resume(returning: image)
                        } else if let error = response.error {
                            continuation.resume(throwing: error)
                        }
                    }
            }
        }
    }
}
