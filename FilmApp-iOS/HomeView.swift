//
//  HomeView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Now Playing Section
                    if !viewModel.nowPlayingMovies.isEmpty {
                        CategoryView(categoryTitle: "Now Playing", movies: viewModel.nowPlayingMovies)
                    } else {
                        Text("Loading...")
                            .font(.title)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Movies")
            .onAppear {
                viewModel.fetchNowPlayingMovies()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct CategoryView: View {
    let categoryTitle: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(categoryTitle)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination: MovieListView(movies: movies, categoryTitle: categoryTitle)) {
                    Text("Show All")
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCell(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



