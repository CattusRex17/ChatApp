//
//  FirebaseMessageService.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import FirebaseFirestore

final class FirebaseMessageService {
    private let db = Firestore.firestore()

    func getMessages(conversationID: String) async throws -> [Message] {
        let snapshot = try await db.collection("conversations")
            .document(conversationID)
            .collection("messages")
            .order(by: "timestamp")
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let senderID = data["senderID"] as? String,
                let text = data["text"] as? String,
                let timestamp = (data["timestamp"] as? Timestamp)?.dateValue()
            else { return nil }

            return Message(id: doc.documentID, senderID: senderID, text: text, timestamp: timestamp)
        }
    }

    func sendMessage(conversationID: String, message: Message) async throws {
        let ref = db.collection("conversations")
            .document(conversationID)
            .collection("messages")
            .document()

        try await ref.setData([
            "senderID": message.senderID,
            "text": message.text,
            "timestamp": message.timestamp
        ])
    }
}
