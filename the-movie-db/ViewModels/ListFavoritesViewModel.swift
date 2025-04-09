//
//  ListFavoritesViewModel.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import UIKit

class ListFavoritesViewModel {

    let viewTitle = "Film favorite"
    var movieViewModel = MovieViewModel()
    var movieDataSource = MovieDataSource()
    var isLoadingMoreData = false
}

// MARK: - Requests
extension ListFavoritesViewModel {

    func fetchfavoriteMovies(nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if isLoadingMoreData {
            return
        }

        isLoadingMoreData = true

        guard var page = self.movieViewModel.page else { return }

        if nextPage {
            guard let totalPages = self.movieViewModel.totalPages else { return }
            if page >= totalPages {
                isLoadingMoreData = false
                return
            }
            page += 1
        }

        self.movieDataSource.fetchMovies(page: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false

            if serviceError != nil {
                // TODO: Tratar erro
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                if nextPage {
                    self.movieViewModel.movies?.append(contentsOf: viewModel.movies ?? [])
                } else {
                    self.movieViewModel.movies = viewModel.movies
                }

                completion(self.movieViewModel)
            }
        }
    }
}
