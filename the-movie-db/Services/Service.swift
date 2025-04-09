//
//  Service.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import Foundation

class Service {

    // MARK: - Utility
    
    func createApiUrl(with path:String, queryItems: [URLQueryItem]) -> URL? {
        var query = [
            URLQueryItem(name: "api_key", value: Constants.api().key),
        ]
        query.append(contentsOf: queryItems)
        var urlComponents = URLComponents(string: "\(Constants.api().url)\(path)")
        urlComponents?.queryItems = query
        return urlComponents?.url
    }
}
