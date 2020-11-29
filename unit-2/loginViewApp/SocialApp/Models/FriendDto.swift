//
//  FriendDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
import RealmSwift

class FriendDto : Object, Decodable, DataObject {
    @objc dynamic var name: String = ""
    @objc dynamic var mainImage: String = ""
    var images: [String]? = []
    @objc dynamic var first_name : String? = ""
    @objc dynamic var id : Int = -1
    @objc dynamic var last_name : String? = ""
    @objc dynamic var can_access_closed : Bool = false
    @objc dynamic var is_closed : Bool = false
    @objc dynamic var track_code : String? = ""

    enum CodingKeys: String, CodingKey {

        case first_name = "first_name"
        case id = "id"
        case last_name = "last_name"
        case can_access_closed = "can_access_closed"
        case is_closed = "is_closed"
        case photo_50 = "photo_50"
        case track_code = "track_code"
    }
    
    override init(){
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        id = try! values.decodeIfPresent(Int.self, forKey: .id)!
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        can_access_closed = try values.decodeIfPresent(Bool.self, forKey: .can_access_closed) ?? false
        is_closed = try values.decodeIfPresent(Bool.self, forKey: .is_closed) ?? false
        mainImage = try! values.decodeIfPresent(String.self, forKey: .photo_50)!
        track_code = try values.decodeIfPresent(String.self, forKey: .track_code)
        name = "\(String(describing: first_name!)) \(String(describing: last_name!))"
        images = nil
    }
}
