//
//  AuthRepository.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

protocol AuthRepository {
    func login(email: String, password: String) async throws -> User
    func getCurrentUser() -> User?
}
