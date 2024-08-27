//
//  LoginView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 27.08.24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            if isLoggedIn {
                Text("Welcome!")
                    .font(.largeTitle)
                    .padding()
                    
            } else {
                Image("tmdb")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 300, height: 300) // Resmin orantılı ve boyutlu olmasını sağlar
                       .padding(.bottom, 20)
                    
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    authenticateUser()
                }, label: {
                    Text("Login")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .padding()
            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
        
    
    private func authenticateUser() {
        // API çağrısını burada yapacağız.
        let auth = APIAuth()
        auth.fetchAuthenticationData { response in
            DispatchQueue.main.async {
                if let response = response, response.success {
                    self.isLoggedIn = true
                } else {
                    self.errorMessage = "Login failed. Please try again."
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var isLoggedIn = false

        LoginView(isLoggedIn: $isLoggedIn)  // Use the dummy state as the binding
    }
}


