//
//  GroupDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
import RealmSwift

class GroupDto : Object, Decodable, DataObject {
    @objc dynamic var id : Int = -1
    @objc dynamic var name : String = ""
    @objc dynamic var screen_name : String? = ""
    @objc dynamic var is_closed : Int = -1
    @objc dynamic var type : String? = ""
    @objc dynamic var is_admin : Int = -1
    @objc dynamic var is_member : Int = -1
    @objc dynamic var is_advertiser : Int = -1
    @objc dynamic var mainImage : String = ""
    @objc dynamic var photo_100 : String? = ""
    @objc dynamic var photo_200 : String? = ""
    var images: [String]? = []
    @objc dynamic var userId: Int = 0

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
    
    override init() {
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try! values.decodeIfPresent(Int.self, forKey: .id)!
        name = try! values.decodeIfPresent(String.self, forKey: .name)!
        screen_name = try values.decodeIfPresent(String.self, forKey: .screen_name)
        is_closed = try values.decodeIfPresent(Int.self, forKey: .is_closed) ?? -1
        type = try values.decodeIfPresent(String.self, forKey: .type)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin) ?? -1
        is_member = try values.decodeIfPresent(Int.self, forKey: .is_member) ?? -1
        is_advertiser = try values.decodeIfPresent(Int.self, forKey: .is_advertiser) ?? -1
        mainImage = try! values.decodeIfPresent(String.self, forKey: .photo_50)!
        photo_100 = try values.decodeIfPresent(String.self, forKey: .photo_100)
        photo_200 = try values.decodeIfPresent(String.self, forKey: .photo_200)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
