//
//  SearchViewModel.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 14.08.24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                if searchText.isEmpty {
                    self?.fetchRandomMovies()
                } else {
                    self?.searchMovies(query: searchText)
                }
            }
            .store(in: &cancellables)
    }

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            isLoading = false
            errorMessage = nil
            return
        }

        isLoading = true
        errorMessage = nil

        apiService.searchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.searchResults = movies
                case .failure(let error):
                    self?.errorMessage = "Error searching movies: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func fetchRandomMovies() {
        isLoading = true
        errorMessage = nil

        // Rastgele bir film listesini alıyoruz (örneğin, popüler filmler)
        apiService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.searchResults = movies.shuffled() // Filmleri karıştırarak rastgele göster
                case .failure(let error):
                    self?.errorMessage = "Error fetching random movies: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func clearSearch() {
        searchText = ""
        fetchRandomMovies()
        isLoading = false
        errorMessage = nil
    }
}



