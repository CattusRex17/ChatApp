//
//  Message.swift
//  ChatApp
//
//  Created by Mauricio Rodriguez on 4/4/2025.
//

import Foundation

struct Message: Identifiable {
    let id: String
    let senderID: String
    let text: String
    let timestamp: Date
}
