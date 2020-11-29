//
//  Response.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
class Response<TItem : Decodable> : Decodable {
    let count: Int
    let items: [TItem]

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case items = "items"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try! values.decodeIfPresent(Int.self, forKey: .count) ?? 0
        items = try! values.decodeIfPresent([TItem].self, forKey: .items)!
    }
}
