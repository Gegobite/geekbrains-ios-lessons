//
//  GroupsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 22.11.2020.
//

import Alamofire
import RealmSwift

protocol GroupsServiceDelegate {
    func getUserGroups(userId: Int, completion: @escaping (String) -> Void)
    func getGroupsByUserIdAsync(userId: Int, completion: @escaping ([GroupDto]?) -> Void)
    func searchGroups(by substring: String, completion: @escaping (String) -> Void)
    func getByUserIdFromLocal(userId: Int) -> [GroupDto]
    func addOrUpdate(groups: [GroupDto])
}

class GroupsService : GroupsServiceDelegate {
    
    private let client: HttpClient
    
    init(client: HttpClient){
        self.client = client
    }
    
    func getUserGroups(userId: Int, completion: @escaping (String) -> Void) {
        let params: Parameters = [
            "user_id": userId,
            "extended": 1,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]

        client.getFromJson(path: "groups.get", params: params){ json in
            completion("")
        }
    }
    
    func getGroupsByUserIdAsync(userId: Int, completion: @escaping ([GroupDto]?) -> Void){
        let params: Parameters = [
            "user_id": userId,
            "extended": 1,
            "count": 10,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]
        
        client.getFromJson(ResponseObject<GroupDto>.self, path: "groups.get", params: params){ data in
            let items = data?.response?.items
            items?.forEach{ $0.userId = userId }
            completion(items ?? nil)
        }
    }
    
    func searchGroups(by substring: String, completion: @escaping (String) -> Void) {
        let params: Parameters = [
            "q": substring,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]

        return client.getFromJson(path: "groups.search", params: params) { json in
            completion("")
        }
    }
    
    func getByUserIdFromLocal(userId: Int) -> [GroupDto] {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let groups = realm.objects(GroupDto.self).filter("userId = \(userId)")
            return Array(groups)
        } catch  {
            print(error)
            return []
        }
    }
    
    func addOrUpdate(groups: [GroupDto]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(groups, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
