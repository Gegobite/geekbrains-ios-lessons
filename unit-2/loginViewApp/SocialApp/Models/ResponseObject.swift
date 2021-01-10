//
//  Response.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
class ResponseObject<TItem : Decodable> : Decodable {
    let response : Response<TItem>?

    enum CodingKeys: String, CodingKey {

        case response = "response"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try! values.decodeIfPresent(Response<TItem>.self, forKey: .response)
    }
}
