//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation
import FirebaseFirestore

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    var userID: String?

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    @MainActor
    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Correo y contraseña son obligatorios"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let user = try await loginUseCase.execute(email: email, password: password)
            self.userID = user.id
            self.isLoggedIn = true
            
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user.id)

            try? await userRef.setData([
                "email": self.email
            ], merge: true)

        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
