//
//  MovieListView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 06.08.24.
//

import SwiftUI

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
