// User.swift
import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String
    let password: String
    
    init(id: UUID = UUID(), username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
