//
//  ContentView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Homepage")
                }

            FavouritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }

            OthersView()
                .tabItem {
                    Image(systemName: "ellipsis.circle.fill")
                    Text("Others")
                }
        }
        .preferredColorScheme(.dark)
    }
}

struct FavouritesView: View {
    var body: some View {
        NavigationView {
            Text("Favourites View")
                .navigationBarTitle("Favourites")
        }
    }
}

struct OthersView: View {
    var body: some View {
        NavigationView {
            Text("Others View")
                .navigationBarTitle("Others")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


