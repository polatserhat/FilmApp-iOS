//
//  MovieCell.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import SwiftUI

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
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

