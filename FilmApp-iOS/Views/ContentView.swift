//
//  ContentView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            SearchView(viewModel: viewModel)
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }

            OthersView()
                .tabItem {
                    Image(systemName: "movieclapper")
                    Text("Movie")
                }
        }
        .preferredColorScheme(.dark)
    }
}



struct OthersView: View {
    var body: some View {
        NavigationView {
            Text("Movie View")
                .navigationBarTitle("Movie")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


