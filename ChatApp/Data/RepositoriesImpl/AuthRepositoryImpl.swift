//
//  AuthRepositoryImpl.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

final class AuthRepositoryImpl: AuthRepository {
    private let authService = FirebaseAuthService()

    func login(email: String, password: String) async throws -> User {
        let result = try await authService.login(email: email, password: password)
        return User(id: result.user.uid, email: result.user.email ?? "")
    }

    func getCurrentUser() -> User? {
        return authService.getCurrentUser()
    }
}
