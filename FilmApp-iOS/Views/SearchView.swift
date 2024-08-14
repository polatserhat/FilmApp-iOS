//
//  SearchView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 14.08.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Arama Barı
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Filmler Listesi
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(filteredMovies) { movie in
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
            .preferredColorScheme(.dark)
            .navigationBarTitle("TMDB", displayMode: .inline)
            .onAppear {
                viewModel.fetchAllData() // Tüm filmleri yükle
            }
        }
    }
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return viewModel.allMovies
        } else {
            return viewModel.allMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}




struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: HomeViewModel())
    }
}


