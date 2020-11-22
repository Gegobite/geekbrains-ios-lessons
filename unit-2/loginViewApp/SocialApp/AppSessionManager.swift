//
//  SessionManager.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

class AppSessionManager {
    static var currentSession: AppSessionManager = AppSessionManager()
    
    var token: String
    var userId: Int
    
    private init() {
        token = ""
        userId = -1
    }
}
