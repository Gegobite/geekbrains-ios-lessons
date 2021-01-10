//
//  PhotosService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 22.11.2020.
//

import Alamofire

protocol PhotosServiceDelegate {
    func getUserPhotos(userId: Int, completion: @escaping (String) -> Void)
    func getByUserIdAsync(userId: Int, completion: @escaping ([PhotoDto]?) -> Void)
}

class PhotosService : PhotosServiceDelegate {
    
    private let client: HttpClient
    
    init(client: HttpClient){
        self.client = client
    }
    
    func getUserPhotos(userId: Int, completion: @escaping (String) -> Void) {
        let params: Parameters = [
            "owner_id": userId,
            "extended": 1,
            "photo_sizes": 1,
            "skip_hidden": 1,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]

        return client.getFromJson(path: "photos.getAll", params: params){ json in
            completion("json")
        }
    }
    
    func getByUserIdAsync(userId: Int, completion: @escaping ([PhotoDto]?) -> Void) {
        let params: Parameters = [
            "owner_id": userId,
            "extended": 1,
            "count": 5,
            "photo_sizes": 1,
            "skip_hidden": 1,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]
        
        client.getFromJson(ResponseObject<PhotoDto>.self, path: "photos.getAll", params: params){ data in
            completion(data?.response?.items ?? nil)
        }
    }
}
