//
//  FilmApp_iOSApp.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 05.08.24.
//

import SwiftUI

@main
struct FilmApp_iOSApp: App {
    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()  // Kullanıcı giriş yaptıysa ana içerik ekranı göster
            } else {
                LoginView(isLoggedIn: $isLoggedIn)  // Kullanıcı giriş yapmadıysa login ekranı göster
            }
        }
    }
}

