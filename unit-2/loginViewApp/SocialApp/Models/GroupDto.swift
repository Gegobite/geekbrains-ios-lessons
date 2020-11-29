//
//  GroupDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
struct GroupDto : Decodable, DataObject {
    var id : Int
    var name : String
    let screen_name : String?
    let is_closed : Int?
    let type : String?
    let is_admin : Int?
    let is_member : Int?
    let is_advertiser : Int?
    var mainImage : String
    let photo_100 : String?
    let photo_200 : String?
    var images: [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case screen_name = "screen_name"
        case is_closed = "is_closed"
        case type = "type"
        case is_admin = "is_admin"
        case is_member = "is_member"
        case is_advertiser = "is_advertiser"
        case photo_50 = "photo_50"
        case photo_100 = "photo_100"
        case photo_200 = "photo_200"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try! values.decodeIfPresent(Int.self, forKey: .id)!
        name = try! values.decodeIfPresent(String.self, forKey: .name)!
        screen_name = try values.decodeIfPresent(String.self, forKey: .screen_name)
        is_closed = try values.decodeIfPresent(Int.self, forKey: .is_closed)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        is_member = try values.decodeIfPresent(Int.self, forKey: .is_member)
        is_advertiser = try values.decodeIfPresent(Int.self, forKey: .is_advertiser)
        mainImage = try! values.decodeIfPresent(String.self, forKey: .photo_50)!
        photo_100 = try values.decodeIfPresent(String.self, forKey: .photo_100)
        photo_200 = try values.decodeIfPresent(String.self, forKey: .photo_200)
    }

}
