//
//  SessionManager.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

class SessionManager {
    static var currentSession: SessionManager = SessionManager()
    
    var token: String
    var userId: Int
    
    private init() {
        token = ""
        userId = -1
    }
}
