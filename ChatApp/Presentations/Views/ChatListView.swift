//
//  ChatListView.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject var viewModel: ChatListViewModel
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else if viewModel.conversations.isEmpty {
                    Text("No tienes conversaciones activas.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.conversations) { convo in
                        NavigationLink(
                            destination: ChatDetailView(
                                viewModel: ChatDetailViewModel(
                                    repository: MessageRepositoryImpl(),
                                    conversationID: convo.id,
                                    userID: viewModel.userID
                                )
                            )
                        ) {
                            VStack(alignment: .leading) {
                                Text(convo.title).bold()
                                Text(convo.lastMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Mis Chats")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewConversationView(userID: viewModel.userID)) {
                        Image(systemName: "plus.message")
                    }
                    NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn)) {
                        Image(systemName: "person.circle")
                    }

                }
            }
            .task {
                await viewModel.loadConversations()
            }
        }
    }
}
