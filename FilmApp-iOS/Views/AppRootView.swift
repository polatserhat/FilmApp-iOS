//
//  AppRootView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 28.08.24.
//

import SwiftUI

struct AppRootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("isDarkMode") var isDarkMode = false

    var body: some View {
        if isLoggedIn {
            HomeView()
                .onAppear {
                    applyTheme()
                }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
                .onAppear {
                    applyTheme()
                }
        }
    }
    
    private func applyTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}


