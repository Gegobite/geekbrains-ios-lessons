//
//  FriendDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
struct FriendDto : Decodable, DataObject {
    var name: String
    var mainImage: String
    var images: [String]?
    let first_name : String?
    var id : Int
    let last_name : String?
    let can_access_closed : Bool?
    let is_closed : Bool?
    let track_code : String?

    enum CodingKeys: String, CodingKey {

        case first_name = "first_name"
        case id = "id"
        case last_name = "last_name"
        case can_access_closed = "can_access_closed"
        case is_closed = "is_closed"
        case photo_50 = "photo_50"
        case track_code = "track_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        id = try! values.decodeIfPresent(Int.self, forKey: .id)!
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        can_access_closed = try values.decodeIfPresent(Bool.self, forKey: .can_access_closed)
        is_closed = try values.decodeIfPresent(Bool.self, forKey: .is_closed)
        mainImage = try! values.decodeIfPresent(String.self, forKey: .photo_50)!
        track_code = try values.decodeIfPresent(String.self, forKey: .track_code)
        name = "\(String(describing: first_name!)) \(String(describing: last_name!))"
        images = nil
    }
}
