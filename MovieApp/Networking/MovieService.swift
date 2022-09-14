//
//  MovieService.swift
//  MovieApp
//
//  Created by Berk Pehlivanoğlu on 12.09.2022.
//

import Moya
import SwiftUI

enum MovieService {

    case search(title: String)
    case showDetail(title: String)
}

extension MovieService: TargetType {

    var baseURL: URL {
        return URL(string: "https://www.omdbapi.com/")!
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var path: String {
        switch self {
        case .search:
            return ""
        case .showDetail:
            return ""
        }
        
    }

    var method: Moya.Method {
        switch self {
        case .search, .showDetail:
            return .post
        }
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .search(let title):
            return .requestParameters(parameters: ["s": title, "apikey": "2bf07182"], encoding: URLEncoding.queryString)
        case .showDetail(let title):
            return .requestParameters(parameters: ["t": title, "apikey": "2bf07182", "plot": "full"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }

}
