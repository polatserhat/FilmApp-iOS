//
//  HomeView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//
import SwiftUI

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Spacer() // Sol tarafta boşluk bırakıyoruz
                        
                        Text("TMDB")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10) // Üst boşluk ekleniyor
                        
                        Spacer() // Sağ tarafta boşluk bırakıyoruz
                    }
                    .padding(.horizontal)
                    
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
                .background(Color.black) // Arka plan rengini koyu yapıyoruz

                // Ayarlar butonunu sağ üst köşeye yerleştiriyoruz
                VStack {
                    HStack {
                        Spacer() // Sağ üst köşe için boşluk
                        settingsButton
                    }
                    Spacer() // Butonu yukarıda tutmak için alt taraf boşluğu
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


var settingsButton: some View {
    NavigationLink(destination: SettingsView()) {
        Image(systemName: "gearshape")
            .imageScale(.large)
            .padding(10)
            .foregroundColor(.white)
            .fontWeight(.bold)
            
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .navigationBarTitle("Settings", displayMode: .inline)
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



