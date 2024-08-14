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
    let releaseDate: String?
    let posterPath: String?
    let originalLanguage: String
    
    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
    
    var formattedReleaseDate: String {
        guard let releaseDate = releaseDate else {
            return "N/A"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: releaseDate) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return releaseDate
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}





