//
//  MessageRepository.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation

protocol MessageRepository {
    func getMessages(conversationID: String) async throws -> [Message]
    func sendMessage(conversationID: String, message: Message) async throws
}
