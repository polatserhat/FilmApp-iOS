//
//  HomeView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var userDetails: UserDetails? = nil // Kullanıcı bilgilerini tutacağız
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Text("TMDB")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .padding(.bottom,20)
                        
                        Spacer()
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
                            
                            //Upcoming Section
                            CategoryView(categoryTitle: "Upcoming", movies: viewModel.upcomingMovies)
                        }
                    }
                }
                .background(Color.black)
                
                // Sağ üst köşede profil butonu
                VStack {
                    HStack {
                        Spacer()
                        profileButton // Yeni profil butonu
                    }
                    Spacer()
                }
            }
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchNowPlayingMovies(completion: {})
                viewModel.fetchPopularMovies(completion: {})
                viewModel.fetchTopRatedMovies(completion: {})
                viewModel.fetchUpcomingMovies(completion: {})
                loadUserDetails() // Kullanıcı detaylarını yükle
            }
        }
    }
    
    // Profil butonu için NavigationLink
    var profileButton: some View {
        NavigationLink(destination: ProfileView(userDetails: userDetails)) {
            if let avatarPath = userDetails?.avatar?.tmdb?.avatar_path, !avatarPath.isEmpty {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + avatarPath)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
        }
        .padding(10)
    }
    
    func loadUserDetails() {
        // APIUser sınıfından kullanıcı bilgilerini çek
        APIUser().fetchUserDetails { details in
            DispatchQueue.main.async {
                self.userDetails = details
            }
        }
    }
}

struct CategoryView: View {
    let categoryTitle: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCell(movie: movie)
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.white)
            }
        }
        .padding(.vertical, 10)
        .background(Color.black)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




