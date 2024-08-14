//
//  SearchView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 14.08.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        ZStack {
            
        VStack {
            HStack {
                Spacer() // Sol tarafta boşluk bırakıyoruz
                
                Text("TMDB")
                    .font(.title2)
                    .fontWeight(.bold)
                   .padding(.top, 10) // Üst boşluk ekleniyor
                   
                
                Spacer() // Sağ tarafta boşluk bırakıyoruz
            }
            .padding(.horizontal)
            // Search Bar
            TextField("Search movies...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Spacer()
            
            // Placeholder for search results
            Text("Search results will appear here")
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
    }
        .preferredColorScheme(.dark)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

