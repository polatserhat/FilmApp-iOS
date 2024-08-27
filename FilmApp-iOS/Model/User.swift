//
//  Serie.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 16.08.24.
//

import Foundation

import Foundation

struct UserDetails: Codable {
    let avatar: Avatar?
    let id: Int
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let include_adult: Bool
    let username: String
}

struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: TMDB?
}

struct Gravatar: Codable {
    let hash: String
}

struct TMDB: Codable {
    let avatar_path: String?
}


