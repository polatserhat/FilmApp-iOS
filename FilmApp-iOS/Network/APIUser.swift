//
//  APIUser.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 27.08.24.
//

import Foundation

class APIUser {

    let apiURL = "https://api.themoviedb.org/3/account/21090862"
    let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YTUzZWEzYTMzY2VjYmJhYjg4NmNkMWVmN2MwNTY1YyIsIm5iZiI6MTcyNDY4Nzg0OC4zOTE2MTQsInN1YiI6IjY1ZWYxOWZkZjVjYjIxMDE2MjQ1NjU3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.V2_1YaiNxAlhNMzRRzbC79mlOfh71VHgzkQzvxIOiaE"

    func fetchUserDetails(completion: @escaping (UserDetails?) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during API call: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(UserDetails.self, from: data)
                completion(decodedResponse)
            } catch {
                print("Failed to decode JSON response: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}

