//
//  MovieDetailView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 06.08.24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var viewModel = MovieDetailViewModel()
    
    var body: some View {
        VStack {
            if let imageURL = viewModel.fullImageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Loading image...")
                    .font(.title)
                    .padding()
            }
            Text(movie.title)
                .font(.title)
                .padding()
            Text(movie.overview)
                .padding()
            Spacer()
        }
        .navigationBarTitle(movie.title, displayMode: .inline)
        .onAppear {
            viewModel.fetchMovieImages(movieId: movie.id)
        }
    }
}

class MovieDetailViewModel: ObservableObject {
    @Published var fullImageURL: URL?
    
    private let apiService = APIService()
    
    func fetchMovieImages(movieId: Int) {
        apiService.fetchMovieImages(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.fullImageURL = images.first?.fullImageURL
                case .failure(let error):
                    print("Error fetching images: \(error)")
                }
            }
        }
    }
}

