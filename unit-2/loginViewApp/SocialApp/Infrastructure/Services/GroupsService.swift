//
//  GroupsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 22.11.2020.
//

import Alamofire

protocol GroupsServiceDelegate {
    func getUserGroups(userId: Int, completion: @escaping (String) -> Void)
    func searchGroups(by substring: String, completion: @escaping (String) -> Void)
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
            completion(json)
        }
    }
    
    func searchGroups(by substring: String, completion: @escaping (String) -> Void) {
        let params: Parameters = [
            "q": substring,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]

        return client.getFromJson(path: "groups.search", params: params) { json in
            completion(json)
        }
    }
    
    
}
