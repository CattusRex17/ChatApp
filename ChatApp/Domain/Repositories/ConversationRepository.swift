//
//  ConversationRepository.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

protocol ConversationRepository {
    func getUserConversations(userID: String) async throws -> [Conversation]
}
