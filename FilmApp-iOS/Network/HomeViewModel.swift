//
//  HomeViewModel.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []

    private let apiService = APIService()

    func fetchNowPlayingMovies() {
        apiService.fetchNowPlayingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.nowPlayingMovies = movies
                case .failure(let error):
                    print("Error fetching now playing movies: \(error)")
                }
            }
        }
    }
    
    func fetchPopularMovies() {
        apiService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.popularMovies = movies
                case .failure(let error):
                    print("Error fetching popular movies: \(error)")
                }
            }
        }
    }

    func fetchTopRatedMovies() {
        apiService.fetchTopRatedMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.topRatedMovies = movies
                case .failure(let error):
                    print("Error fetching top rated movies: \(error)")
                }
            }
        }
    }
    func fetchUpcomingMovies() {
        apiService.fetchUpcomingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.upcomingMovies = movies
                case .failure(let error):
                    print("Error fetching upcoming movies: \(error)")
                }
            }
        }
    }
}



