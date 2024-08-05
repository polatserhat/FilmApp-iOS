//
//  ContentView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Homepage")
                }

            FavouritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }

            OthersView()
                .tabItem {
                    Image(systemName: "ellipsis.circle.fill")
                    Text("Others")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Now Playing Section
                    CategoryView(categoryTitle: "Now Playing", movies: sampleMovies)
                    
                    // Popular Section
                    CategoryView(categoryTitle: "Popular", movies: sampleMovies)
                    
                    // Top Rated Section
                    CategoryView(categoryTitle: "Top Rated", movies: sampleMovies)
                }
            }
            .navigationBarTitle("Movies")
        }
    }
}

struct FavouritesView: View {
    var body: some View {
        NavigationView {
            Text("Favourites View")
                .navigationBarTitle("Favourites")
        }
    }
}

struct OthersView: View {
    var body: some View {
        NavigationView {
            Text("Others View")
                .navigationBarTitle("Others")
        }
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
                        .foregroundColor(.blue)
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

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL)
                    .frame(width: 150, height: 225)
                    .cornerRadius(10)
            } else {
                Color.gray
                    .frame(width: 150, height: 225)
                    .cornerRadius(10)
            }
            Text(movie.title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(width: 150)
        }
    }
}

struct MovieListView: View {
    let movies: [Movie]
    let categoryTitle: String
    
    var body: some View {
        List(movies) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                Text(movie.title)
            }
        }
        .navigationBarTitle(categoryTitle)
    }
}

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL)
                    .frame(width: 300, height: 450)
                    .cornerRadius(10)
            } else {
                Color.gray
                    .frame(width: 300, height: 450)
                    .cornerRadius(10)
            }
            Text(movie.title)
                .font(.title)
                .padding()
            Text(movie.overview)
                .padding()
            Spacer()
        }
        .navigationBarTitle(movie.title, displayMode: .inline)
    }
}

// Sample data 
struct Movie: Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    var posterURL: URL? {
        if let path = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }
}

let sampleMovies = [
    Movie(id: 1, title: "Movie 1", overview: "Overview of Movie 1", posterPath: "/path1.jpg"),
    Movie(id: 2, title: "Movie 2", overview: "Overview of Movie 2", posterPath: "/path2.jpg"),
    Movie(id: 3, title: "Movie 3", overview: "Overview of Movie 3", posterPath: "/path3.jpg")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

