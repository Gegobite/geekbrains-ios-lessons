//
//  ConnectionSettings.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

class ConnectionSettings {
    static var current: ConnectionSettings = ConnectionSettings()
    
    let clientId: String
    let clientScope: String
    let apiVersion: String
    let apiUrl: String
    
    private init(){
        clientId = "7670661"
        clientScope = "262150"
        apiVersion = "5.126"
        apiUrl = "https://api.vk.com/method/"
    }
}
