//
//  Serie.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 16.08.24.
//

import Foundation

struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

struct Gravatar: Codable {
    let hash: String
}

struct Tmdb: Codable {
    let avatar_path: String
}

struct UserDetails: Codable {
    let avatar: Avatar
    let id: Int
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let include_adult: Bool
    let username: String
}

