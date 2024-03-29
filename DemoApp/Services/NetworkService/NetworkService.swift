//
//  NetworkService.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Alamofire
import Foundation

class NetworkService: NetworkServicing {
    func request<T: Decodable>(url: URL, headers: HTTPHeaders? = nil) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { responce in
                    if let value = responce.value {
                        continuation.resume(returning: value)
                    } else if let error = responce.error {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
