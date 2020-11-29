//
//  PhotoDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
import RealmSwift

class PhotoDto : Object, Decodable {
    @objc dynamic var album_id : Int = -1
    @objc dynamic var date : Int = -1
    @objc dynamic var id : Int = -1
    @objc dynamic var owner_id : Int = -1
    @objc dynamic var has_tags : Bool = false
    @objc dynamic var lat : Double = 0
    @objc dynamic var long : Double = 0
    var sizes : [Sizes]? = []
    @objc dynamic var text : String? = ""
    @objc dynamic var real_offset : Int = -1

    enum CodingKeys: String, CodingKey {

        case album_id = "album_id"
        case date = "date"
        case id = "id"
        case owner_id = "owner_id"
        case has_tags = "has_tags"
        case lat = "lat"
        case long = "long"
        case sizes = "sizes"
        case text = "text"
        case likes = "likes"
        case reposts = "reposts"
        case real_offset = "real_offset"
    }
    
    override init() {
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album_id = try values.decodeIfPresent(Int.self, forKey: .album_id) ?? -1
        date = try values.decodeIfPresent(Int.self, forKey: .date) ?? -1
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        owner_id = try values.decodeIfPresent(Int.self, forKey: .owner_id) ?? -1
        has_tags = try values.decodeIfPresent(Bool.self, forKey: .has_tags) ?? false
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? -1
        long = try values.decodeIfPresent(Double.self, forKey: .long) ?? -1
        sizes = try values.decodeIfPresent([Sizes].self, forKey: .sizes) ?? []
        text = try values.decodeIfPresent(String.self, forKey: .text)
        real_offset = try values.decodeIfPresent(Int.self, forKey: .real_offset) ?? -1
    }
}

class Sizes : Object, Decodable {
    @objc dynamic var height : Int = 0
    @objc dynamic var url : String? = ""
    @objc dynamic var type : String? = ""
    @objc dynamic var width : Int = 0

    enum CodingKeys: String, CodingKey {

        case height = "height"
        case url = "url"
        case type = "type"
        case width = "width"
    }
    
    override init(){
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height) ?? 0
        url = try values.decodeIfPresent(String.self, forKey: .url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        width = try values.decodeIfPresent(Int.self, forKey: .width) ?? 0
    }

}
