//
//  Movie.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 13.09.2022.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let title, year, imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
