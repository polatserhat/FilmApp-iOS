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
        VStack(spacing: 4) {
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
                .frame(width: 100, height: 150)
                .cornerRadius(10)
                .padding(.horizontal, 2) // Poster etrafındaki yatay padding azaltıldı
                .padding(.vertical, 4)   // Poster etrafındaki dikey padding azaltıldı
            } else {
                Color.gray
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 4)
            }
            Text(movie.title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
    }
}


