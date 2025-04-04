//
//  ChatDetailViewModel.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation

final class ChatDetailViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessage: String = ""

    private let repository: MessageRepository
    private let conversationID: String
    let userID: String

    init(repository: MessageRepository, conversationID: String, userID: String) {
        self.repository = repository
        self.conversationID = conversationID
        self.userID = userID
    }

    @MainActor
    func loadMessages() async {
        do {
            self.messages = try await repository.getMessages(conversationID: conversationID)
        } catch {
            print("Error al cargar mensajes: \(error.localizedDescription)")
        }
    }

    @MainActor
    func sendMessage() async {
        let message = Message(id: UUID().uuidString, senderID: userID, text: newMessage, timestamp: Date())
        do {
            try await repository.sendMessage(conversationID: conversationID, message: message)
            self.newMessage = ""
            await loadMessages()
        } catch {
            print("Error al enviar mensaje: \(error.localizedDescription)")
        }
    }
}
