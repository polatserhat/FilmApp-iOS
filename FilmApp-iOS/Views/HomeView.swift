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
                    ZStack(alignment: .top) { // ZStack ile başlığı ve içerik kısmını üst üste koyuyoruz
                        VStack(spacing: 0) {
                            // Sabit başlık
                            Text("TMDB")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()

                            // İçerik kısmı
                            ScrollView {
                                VStack {
                                    // Now Playing Section
                                    CategoryView(categoryTitle: "Now Playing", movies: viewModel.nowPlayingMovies)

                                    // Popular Section
                                    CategoryView(categoryTitle: "Popular", movies: viewModel.popularMovies)

                                    // Top Rated Section
                                    CategoryView(categoryTitle: "Top Rated", movies: viewModel.topRatedMovies)

                                    // Upcoming Section
                                    CategoryView(categoryTitle: "Upcoming", movies: viewModel.upcomingMovies)
                                }
                            }
                        }
                    }
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchNowPlayingMovies()
                viewModel.fetchPopularMovies()
                viewModel.fetchTopRatedMovies()
                viewModel.fetchUpcomingMovies()
            }
        }
    }
}




import SwiftUI

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
                .foregroundColor(.white)
                .fontWeight(.bold)
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



