//
//  NetworkServicing.swift
//  DemoApp
//
//  Created by Andrii Kravtsov on 22.03.2024.
//

import Alamofire
import Foundation

protocol NetworkServicing {
    func request<T: Decodable>(url: URL, headers: HTTPHeaders?) async throws -> T
}
