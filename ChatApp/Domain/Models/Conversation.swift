//
//  Conversations.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation

struct Conversation: Identifiable {
    let id: String
    let title: String
    let lastMessage: String
    let lastUpdated: Date
    let participantIDs: [String]
}
