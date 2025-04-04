//
//  NewConversationView.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI
import FirebaseFirestore

struct NewConversationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var recipientEmail = ""
    @State private var isCreating = false
    @State private var error: String?

    let userID: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Nueva Conversación")
                .font(.title)
                .bold()

            TextField("Email del destinatario", text: $recipientEmail)
                .textFieldStyle(.roundedBorder)

            if let error = error {
                Text(error).foregroundColor(.red)
            }

            Button("Crear") {
                Task { await createConversation() }
            }
            .disabled(recipientEmail.isEmpty || isCreating)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }

    private func createConversation() async {
        guard !recipientEmail.isEmpty else { return }
        isCreating = true
        error = nil

        let db = Firestore.firestore()

        do {
            // Buscar usuario por email (supongamos que tenemos colección "users" con email y uid)
            let query = try await db.collection("users")
                .whereField("email", isEqualTo: recipientEmail)
                .getDocuments()

            guard let recipient = query.documents.first else {
                error = "No se encontró el usuario con ese email."
                isCreating = false
                return
            }

            let recipientID = recipient.documentID

            let conversationRef = db.collection("conversations").document()

            try await conversationRef.setData([
                "title": recipientEmail,
                "participantIDs": [userID, recipientID],
                "lastMessage": "",
                "lastUpdated": Timestamp(date: Date())
            ])

            dismiss()
        } catch {
            self.error = error.localizedDescription
        }

        isCreating = false
    }
}
