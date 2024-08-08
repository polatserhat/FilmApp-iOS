//
//  APIService.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import Foundation

class APIService {
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YTUzZWEzYTMzY2VjYmJhYjg4NmNkMWVmN2MwNTY1YyIsInN1YiI6IjY1ZWYxOWZkZjVjYjIxMDE2MjQ1NjU3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.y2RkIboYCWxqVLb1k3fPy9G9t4__0zrk62atLHqNkBk"
    ]

    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1") else {
            completion(.failure(MovieServiceError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(MovieServiceError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(MovieServiceError.decodingError(error)))
            }
        }
        dataTask.resume()
    }
    
    func fetchMovieImages(movieId: Int, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/images") else {
            completion(.failure(MovieServiceError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(MovieServiceError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(ImageResponse.self, from: data)
                let englishPosters = decodedResponse.posters.filter { $0.iso6391 == "en" }
                completion(.success(englishPosters))
            } catch {
                completion(.failure(MovieServiceError.decodingError(error)))
            }
        }
        dataTask.resume()
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1") else {
                completion(.failure(MovieServiceError.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(MovieServiceError.invalidData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(decodedResponse.results))
                } catch {
                    completion(.failure(MovieServiceError.decodingError(error)))
                }
            }
            dataTask.resume()
        }
    func fetchTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1") else {
                completion(.failure(MovieServiceError.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(MovieServiceError.invalidData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(decodedResponse.results))
                } catch {
                    completion(.failure(MovieServiceError.decodingError(error)))
                }
            }
            dataTask.resume()
        }
}

enum MovieServiceError: Error {
    case invalidURL
    case invalidData
    case decodingError(Error)
}

struct ImageData: Decodable {
    let filePath: String
    let iso6391: String?
    
    var fullImageURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(filePath)")
    }
}

struct ImageResponse: Decodable {
    let posters: [ImageData]
}
