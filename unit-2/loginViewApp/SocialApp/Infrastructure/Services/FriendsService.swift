//
//  FriendsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

import Alamofire

protocol FriendsServiceDelegate {
    func getUserFriends(userId: Int, completion: @escaping (String) -> Void)
    func getByUserIdAsync(userId: Int, completion: @escaping ([FriendDto]?) -> Void)
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
            completion("json")
        }
    }
    
    func getByUserIdAsync(userId: Int, completion: @escaping ([FriendDto]?) -> Void) {
        let params: Parameters = [
            "user_id": userId,
            "fields": "photo_50",
            "count": 10,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]
        
        client.getFromJson((ResponseObject<FriendDto>).self, path: "friends.get", params: params) { data in
            
            completion(data?.response?.items ?? nil)
        }
    }
}
