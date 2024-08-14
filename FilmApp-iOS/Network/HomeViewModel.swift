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
    @Published var allMovies: [Movie] = []

    private let apiService = APIService()

    func fetchNowPlayingMovies(completion: @escaping () -> Void) {
        apiService.fetchNowPlayingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.nowPlayingMovies = movies
                case .failure(let error):
                    print("Error fetching now playing movies: \(error)")
                }
                completion()
            }
        }
    }
    
    func fetchPopularMovies(completion: @escaping () -> Void) {
        apiService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.popularMovies = movies
                case .failure(let error):
                    print("Error fetching popular movies: \(error)")
                }
                completion()
            }
        }
    }

    func fetchTopRatedMovies(completion: @escaping () -> Void) {
        apiService.fetchTopRatedMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.topRatedMovies = movies
                case .failure(let error):
                    print("Error fetching top rated movies: \(error)")
                }
                completion()
            }
        }
    }
    
    func fetchUpcomingMovies(completion: @escaping () -> Void) {
        apiService.fetchUpcomingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.upcomingMovies = movies
                case .failure(let error):
                    print("Error fetching upcoming movies: \(error)")
                }
                completion()
            }
        }
    }
    
    func fetchAllMovies() {
        // Tüm veriler yüklendikten sonra bu fonksiyonu çağıracağız
        allMovies = nowPlayingMovies + popularMovies + topRatedMovies + upcomingMovies
    }
    
    func fetchAllData() {
        let group = DispatchGroup()
        
        group.enter()
        fetchNowPlayingMovies {
            group.leave()
        }
        
        group.enter()
        fetchPopularMovies {
            group.leave()
        }
        
        group.enter()
        fetchTopRatedMovies {
            group.leave()
        }
        
        group.enter()
        fetchUpcomingMovies {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.fetchAllMovies()
        }
    }
}



