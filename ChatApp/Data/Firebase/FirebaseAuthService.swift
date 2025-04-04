//
//  FirebaseAuthService.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import FirebaseAuth

final class FirebaseAuthService {
    func login(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                }
            }
        }
    }

    func getCurrentUser() -> User? {
        guard let firebaseUser = Auth.auth().currentUser else { return nil }
        return User(id: firebaseUser.uid, email: firebaseUser.email ?? "")
    }
}
