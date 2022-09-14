//
//  ErrorResponse.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 12.09.2022.
//

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let response, error: String

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
