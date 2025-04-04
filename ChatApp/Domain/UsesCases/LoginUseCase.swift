//
//  LoginUseCase.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

final class LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(email: String, password: String) async throws -> User {
        return try await repository.login(email: email, password: password)
    }
}
