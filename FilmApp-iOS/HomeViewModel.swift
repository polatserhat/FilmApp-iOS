//
//  HomeViewModel.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    
    private let apiService = APIService()
    
    func fetchNowPlayingMovies() {
        apiService.fetchNowPlayingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.nowPlayingMovies = movies
                case .failure(let error):
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}


