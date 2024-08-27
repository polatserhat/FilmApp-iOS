//
//  ProfileView.swift
//  FilmApp-iOS
//
//  Created by Serhat  on 27.08.24.
//

import SwiftUI

struct ProfileView: View {
    @State var userDetails: UserDetails?
    @State var isLoading: Bool = true
    @State var errorMessage: String?
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading user details...")
                    .scaleEffect(1.5)
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            } else if let userDetails = userDetails {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Avatar Image
                        if let avatarPath = userDetails.avatar?.tmdb?.avatar_path, !avatarPath.isEmpty {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + avatarPath)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.gray)
                        }
                        
                        // Name and Username
                        Text(userDetails.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        Text("@\(userDetails.username)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        // User Info Card
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "flag.fill")
                                    .foregroundColor(.blue)
                                Text("Country: \(userDetails.iso_3166_1)")
                            }
                            
                            HStack {
                                Image(systemName: "globe")
                                    .foregroundColor(.blue)
                                Text("Language: \(userDetails.iso_639_1)")
                            }
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("Include Adult Content: \(userDetails.include_adult ? "Yes" : "No")")
                            }
                        }
                        .preferredColorScheme(.dark)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                }
            } else {
                Text("No user details available")
                    .font(.headline)
                    .padding()
            }
        }
        .onAppear {
            loadUserDetails()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func loadUserDetails() {
        APIUser().fetchUserDetails { details in
            DispatchQueue.main.async {
                if let details = details {
                    self.userDetails = details
                    self.isLoading = false
                } else {
                    self.errorMessage = "Failed to load user details"
                    self.isLoading = false
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userDetails: UserDetails(avatar: Avatar(gravatar: Gravatar(hash: ""), tmdb: TMDB(avatar_path: "/xy44UvpbTgzs9kWmp4C3fEaCl5h.png")), id: 548, iso_639_1: "en", iso_3166_1: "CA", name: "Travis Bell", include_adult: false, username: "travisbell"))
    }
}


