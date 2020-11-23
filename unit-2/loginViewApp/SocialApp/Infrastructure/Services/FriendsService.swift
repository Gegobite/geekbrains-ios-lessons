//
//  FriendsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

import Alamofire

protocol FriendsServiceDelegate {
    func getUserFriends(userId: Int, completion: @escaping (String) -> Void)
}

class FriendsService : FriendsServiceDelegate {
    private var client: HttpClient
    
    init(client: HttpClient){
        self.client = client
    }
    
    func getUserFriends(userId: Int, completion: @escaping (String) -> Void) {
        let params: Parameters = [
            "user_id": userId,
            "fields": "photo_50",
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]

        client.getFromJson(path: "friends.get", params: params) { json in
            completion(json)
        }
    }
}
