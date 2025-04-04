//
//  LoginView.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .bold()

                TextField("Correo electrónico", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                SecureField("Contraseña", text: $viewModel.password)
                    .textContentType(.password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                if viewModel.isLoading {
                    ProgressView()
                }

                Button("Entrar") {
                    Task { await viewModel.login() }
                }
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                NavigationLink(
                    destination: ChatListView(
                        viewModel: ChatListViewModel(
                            useCase: GetUserConversationsUseCase(repository: ConversationRepositoryImpl()),
                            userID: viewModel.userID ?? "",
                            isLoggedIn: $viewModel.isLoggedIn
                        ),
                        isLoggedIn: $viewModel.isLoggedIn
                    ),
                    isActive: $viewModel.isLoggedIn,
                    label: { EmptyView() }
                )
                .hidden()
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

