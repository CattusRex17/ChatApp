//
//  FirebaseChatService.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation
import FirebaseFirestore

final class FirebaseChatService {
    private let db = Firestore.firestore()

    func getUserConversations(userID: String) async throws -> [Conversation] {
        let snapshot = try await db.collection("conversations")
            .whereField("participantIDs", arrayContains: userID)
            .order(by: "lastUpdated", descending: true)
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let title = data["title"] as? String,
                let lastMessage = data["lastMessage"] as? String,
                let lastUpdated = (data["lastUpdated"] as? Timestamp)?.dateValue(),
                let participantIDs = data["participantIDs"] as? [String]
            else {
                return nil
            }

            return Conversation(
                id: doc.documentID,
                title: title,
                lastMessage: lastMessage,
                lastUpdated: lastUpdated,
                participantIDs: participantIDs
            )
        }
    }
}
