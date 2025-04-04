//
//  ProfileView.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Perfil")
                .font(.largeTitle)
                .bold()

            if let email = Auth.auth().currentUser?.email {
                Text("Email: \(email)")
                    .foregroundColor(.gray)
            }

            Button("Cerrar sesión") {
                try? Auth.auth().signOut()
                isLoggedIn = false
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(8)
        }
        .padding()
        .navigationTitle("Perfil")
    }
}
