//
//  GetUserConversationsUseCase.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

final class GetUserConversationsUseCase {
    private let repository: ConversationRepository

    init(repository: ConversationRepository) {
        self.repository = repository
    }

    func execute(userID: String) async throws -> [Conversation] {
        return try await repository.getUserConversations(userID: userID)
    }
}
