//
//  MessageRepositoryImpl.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

final class MessageRepositoryImpl: MessageRepository {
    private let service = FirebaseMessageService()

    func getMessages(conversationID: String) async throws -> [Message] {
        try await service.getMessages(conversationID: conversationID)
    }

    func sendMessage(conversationID: String, message: Message) async throws {
        try await service.sendMessage(conversationID: conversationID, message: message)
    }
}
