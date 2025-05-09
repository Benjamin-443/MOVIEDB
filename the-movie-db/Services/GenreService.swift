//
//  GenreService.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import Foundation

struct Genres: Codable {
    var genres: [Genre] = []
}

class GenreService: Service {

    // MARK: - Requests

    func fetchGenres(with
        completion: @escaping ([Genre]?, GenreServiceError?) -> ()) {

        let path = "/genre/movie/list"

        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, GenreServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, GenreServiceError.CannotFetch())
                    return
                }

                let result = try JSONDecoder().decode(Genres.self, from: data)
                completion(result.genres, nil)
            } catch {
                completion(nil, GenreServiceError.CannotFetch())
            }
        }).resume()
    }
}

// MARK: - Request errors

enum GenreServiceError: Equatable, Error {
  case CannotFetch(String = "Unable to get the list of genres." +
                            "Please check your internet connection.")
}
