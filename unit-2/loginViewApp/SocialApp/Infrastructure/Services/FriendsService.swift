//
//  FriendsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.11.2020.
//

import Alamofire
import RealmSwift

protocol FriendsServiceDelegate {
    func getUserFriends(userId: Int, completion: @escaping (String) -> Void)
    func getByUserIdAsync(userId: Int, completion: @escaping ([FriendDto]?) -> Void)
    func getByUserIdFromLocal(userId: Int) -> [FriendDto]
    func addOrUpdate(friends: [FriendDto])
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
            
            let items = data?.response?.items
            items?.forEach{ $0.userId = userId }
            completion(items ?? nil)
        }
    }
    
    func getByUserIdFromLocal(userId: Int) -> [FriendDto] {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let friends = realm.objects(FriendDto.self).filter("userId = \(userId)")
            return Array(friends)
        } catch  {
            print(error)
            return []
        }
    }
    
    func addOrUpdate(friends: [FriendDto]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(friends, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
