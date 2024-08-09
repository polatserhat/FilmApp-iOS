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
                    ZStack(alignment: .top) {
                        VStack(spacing: 0) {
                            
                            Text("TMDB")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                            
                            Image(systemName: "gearshape")
                            
                            ScrollView {
                                VStack {
                                   
                                    //Now Playing Section
                                    
                                    CategoryView(categoryTitle: "Now Playing", movies: viewModel.nowPlayingMovies)

                                   //Popular Section
                                    
                                    CategoryView(categoryTitle: "Popular", movies: viewModel.popularMovies)

                                    //Top Rated Section
                                    
                                    CategoryView(categoryTitle: "Top Rated", movies: viewModel.topRatedMovies)

                                    // Upcoming Section
                                    CategoryView(categoryTitle: "Upcoming", movies: viewModel.upcomingMovies)
                                }
                            }
                        }
                        settingsButton
                            .padding(.top, 10)
                            .padding(.trailing, 20)
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

var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape.fill")
                .imageScale(.large)
                .padding(10)
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
        }
    }


struct SettingsView: View {
    var body: some View {
        Text("Ayarlar Ekranı")
            .font(.largeTitle)
            .navigationBarTitle("Ayarlar", displayMode: .inline)
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
                .foregroundColor(.white) // Yazıların beyaz renk olmasını sağlar
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



