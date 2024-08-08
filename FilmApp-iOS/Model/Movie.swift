//
//  Movie.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let adult: Bool
    let title: String
    let overview: String
    let popularity: Double
    let releaseDate: String
    let posterPath: String
    let originalLanguage: String
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}




