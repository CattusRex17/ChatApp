//
//  ChatDetailView.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var viewModel: ChatDetailViewModel

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.senderID == viewModel.userID {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                            .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let last = viewModel.messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                }
            }

            HStack {
                TextField("Mensaje...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Enviar") {
                    Task { await viewModel.sendMessage() }
                }
                .disabled(viewModel.newMessage.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat")
        .task {
            await viewModel.loadMessages()
        }
    }
}
