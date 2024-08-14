//
//  SearchMovieCell.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 14.08.24.
//

import SwiftUI
import Foundation

struct SearchMovieCell: View {
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
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 2)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Color.gray
                    .frame(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.width / 2)
                    .cornerRadius(10)
            }
            //Text(movie.title)
              //  .font(.caption)
                //.multilineTextAlignment(.center)
                //.frame(width: UIScreen.main.bounds.width / 3 - 10)
        }
    }
}
