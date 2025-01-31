//
//  SearchView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 14.08.24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Arama Barı
                HStack {
                    TextField("Search", text: $viewModel.searchText)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.clearSearch()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
                
                // Durum Mesajları
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Filmler Listesi
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(viewModel.searchResults) { movie in
                            VStack {
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    AsyncImage(url: movie.posterURL) { image in
                                        image.resizable()
                                            .aspectRatio(2/3, contentMode: .fit) // Dikey poster oranı
                                            .cornerRadius(8) // Köşe yumuşatma
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16) // Yatayda boşluk ayarı
                }
            }
            
            .navigationBarTitle("TMDB", displayMode: .inline)
            .onAppear {
                           viewModel.fetchRandomMovies()
                       }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}



