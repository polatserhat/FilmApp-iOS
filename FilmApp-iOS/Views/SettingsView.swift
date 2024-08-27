//
//  SettingsView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 27.08.24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
            }
            .padding()
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                presentationMode.wrappedValue.dismiss()
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
                
                
    }
        }
    
    
    
    //func updateInterfaceStyle() {
      //  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
       //     return
        //}
       // windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
   // }
    
    
    
    struct AppRootView: View {
        @AppStorage("isLoggedIn") var isLoggedIn = false
        
        var body: some View {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }

