//
//  NewsService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.01.2021.
//

import Foundation
import Alamofire

protocol NewsServiceDelegate {
    func getNewsAsync(completion: @escaping (ResponseNews?) -> Void)
}

class NewsService : NewsServiceDelegate {
    
    private let client: HttpClient
    
    init(client: HttpClient){
        self.client = client
    }
    
    func getNewsAsync(completion: @escaping (ResponseNews?) -> Void) {
        let params: Parameters = [
            "filters": "post",
            "count": 10,
            "access_token": AppSessionManager.currentSession.token,
            "v": ConnectionSettings.current.apiVersion
        ]
        
        client.getFromJson(ResponseNewsResult.self, path: "newsfeed.get", params: params){ data in
            completion(data?.response ?? nil)
        }
    }
}
