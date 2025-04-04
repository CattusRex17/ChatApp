//
//  ChatApp.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import SwiftUI
import Firebase

@main
struct ChatApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            let authRepository = AuthRepositoryImpl()
            let loginUseCase = LoginUseCase(repository: authRepository)
            let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
            LoginView(viewModel: loginViewModel)
        }
    }
}
