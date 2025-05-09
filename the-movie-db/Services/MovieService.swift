//
//  MovieService.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import Foundation

class MovieService: Service {

    // MARK: - Requests

    func fetchPopularMovies(with
        page: Int,
        completion: @escaping (MovieViewModel?, MovieServiceError?) -> ()) {

        let query = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let path = "/movie/popular"

        guard let url = createApiUrl(with: path, queryItems: query) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(MovieViewModel.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetch())
            }
        }).resume()
    }

    func fetchMovie(with
        id: Int,
        completion: @escaping (Movie?, MovieServiceError?) -> ()) {

        let path = "/movie/\(id)"

        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetchMovie())
            }
        }).resume()
    }

    func fetchMovies(with
        search: String,
        page: Int,
        completion: @escaping (MovieViewModel?, MovieServiceError?) -> ()) {

        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "query", value: search)
        ]

        let path = "/search/movie"

        guard let url = createApiUrl(with: path, queryItems: query) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetch())
                    return
                }

                let decoder = JSONDecoder()
                decoder.setCustomDateDecodingStrategy()

                let result = try decoder.decode(MovieViewModel.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetch())
            }
        }).resume()
    }
}

// MARK: - Request errors

enum MovieServiceError: Equatable, Error {
    case CannotFetch(String = "Unable to get movie list. " +
                              "Please check your internet connection.")
    case CannotFetchMovie(String = "Could not get the movie. " +
                                   "Please check your internet connection.")
}
