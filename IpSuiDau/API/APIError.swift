//
//  APIError.swift
//  IpSuiDau
//
//  Created by Ipman on 08/05/2024.
//

import Foundation
enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case statusCode(Int)
    case invalidData
    case jsonParsingError(Error)
}
