//
//  MovieDataSource.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MovieDataSource {

    func saveMovie(movie: Movie, completion: @escaping (Movie?, MovieDataSourceError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, MovieDataSourceError.CannotSave())
            return
        }

        let managedContext = appDelegate.container.viewContext

        let newMovie = CoreDataMovie(context: managedContext)

        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.posterPath, forKey: "posterPath")
        newMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.voteAverage, forKey: "voteAverage")

        do {
            try managedContext.save()
            completion(movie, nil)
        } catch {
            completion(nil, MovieDataSourceError.CannotSave())
        }
    }

    func fetchMovie(movie: Movie, completion: @escaping (Movie?, MovieDataSourceError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, MovieDataSourceError.CannotSave())
            return
        }

        let managedContext = appDelegate.container.viewContext

        let fetchRequest = NSFetchRequest<CoreDataMovie>(entityName: Constants.coreData().movie)
        guard let id = movie.id else {
            completion(nil, MovieDataSourceError.CannotSave())
            return
        }
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            if fetchedResults.first != nil {
                completion(movie, nil)
            } else {
                completion(nil, MovieDataSourceError.CannotFind())
            }
        } catch {
            completion(nil, MovieDataSourceError.CannotSave())
        }
    }

    func fetchMovies(search: String = "", page: Int, completion: @escaping (MovieViewModel?, MovieDataSourceError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, MovieDataSourceError.CannotSave())
            return
        }

        let managedContext = appDelegate.container.viewContext

        let fetchRequest = NSFetchRequest<CoreDataMovie>(entityName: Constants.coreData().movie)

        if !search.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", search)
        }

        var movieViewModel = MovieViewModel()
        movieViewModel.page = page
        movieViewModel.search = search

        do {
            let count = try managedContext.count(for: fetchRequest)
            movieViewModel.totalPages = (count + 20 - 1) / 20

            fetchRequest.fetchLimit = 20
            fetchRequest.fetchOffset = (page - 1) * 20

            let fetchedResults = try managedContext.fetch(fetchRequest)

            for result in fetchedResults {
                movieViewModel.movies?.append(Movie(
                    id: Int(result.id),
                    posterPath: result.posterPath,
                    releaseDate: result.releaseDate,
                    title: result.title,
                    overview: result.overview,
                    voteAverage: result.voteAverage?.decimalValue))
            }

            completion(movieViewModel, nil)
        } catch {
            completion(nil, MovieDataSourceError.CannotSave())
        }
    }

    func removeMovie(movie: Movie, completion: @escaping (Movie?, MovieDataSourceError?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(nil, MovieDataSourceError.CannotRemove())
            return
        }

        let managedContext = appDelegate.container.viewContext

        let fetchRequest = NSFetchRequest<CoreDataMovie>(entityName: Constants.coreData().movie)
        guard let id = movie.id else {
            completion(nil, MovieDataSourceError.CannotRemove())
            return
        }
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            if let result = fetchedResults.first {
                managedContext.delete(result)
                try managedContext.save()
                completion(movie, nil)
            } else {
                completion(nil, MovieDataSourceError.CannotRemove())
            }
        } catch {
            completion(nil, MovieDataSourceError.CannotRemove())
        }
    }
}

// MARK: - Request errors

enum MovieDataSourceError: Equatable, Error {
    case CannotSave(String = "Could not save movie to favorites. Try again.")
    case CannotFind(String = "The movie could not be found.")
    case CannotRemove(String = "Could not remove the film. Try again.")
    case CannotFetch(String = "Unable to get movie list.")
}
