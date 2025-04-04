//
//  ChatListViewModel.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation
import SwiftUI


final class ChatListViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Binding var isLoggedIn: Bool


    private let useCase: GetUserConversationsUseCase
    let userID: String

    init(useCase: GetUserConversationsUseCase, userID: String, isLoggedIn: Binding<Bool>) {
        self.useCase = useCase
        self.userID = userID
        self._isLoggedIn = isLoggedIn
    }

    @MainActor
    func loadConversations() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await useCase.execute(userID: userID)
            self.conversations = result
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

