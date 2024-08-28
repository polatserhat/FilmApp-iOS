//
//  SettingsView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 27.08.24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Dark Mode Toggle
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
            }
            .padding()
            .onChange(of: isDarkMode) { _ in  // Dark Mode değişikliklerini izliyoruz
                updateInterfaceStyle()
            }
            
            // Log Out Button
            Button(action: {
                logOut()
            }) {
                Text("Log Out")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            updateInterfaceStyle()
        }
    }
    
    // Update the interface style based on the dark mode setting
    private func updateInterfaceStyle() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }

    // Log out and return to the login view
    private func logOut() {
        isLoggedIn = false
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


