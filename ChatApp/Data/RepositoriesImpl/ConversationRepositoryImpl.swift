//
//  ConversationRepositoryImpl.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

final class ConversationRepositoryImpl: ConversationRepository {
    private let chatService: FirebaseChatService

    init(chatService: FirebaseChatService = FirebaseChatService()) {
        self.chatService = chatService
    }

    func getUserConversations(userID: String) async throws -> [Conversation] {
        return try await chatService.getUserConversations(userID: userID)
    }
}
