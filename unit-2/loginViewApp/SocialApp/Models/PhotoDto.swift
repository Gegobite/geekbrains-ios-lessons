//
//  PhotoDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 29.11.2020.
//

import Foundation
struct PhotoDto : Decodable {
    let album_id : Int?
    let date : Int?
    let id : Int?
    let owner_id : Int?
    let has_tags : Bool?
    let lat : Double?
    let long : Double?
    let sizes : [Sizes]?
    let text : String?
    let real_offset : Int?

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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album_id = try values.decodeIfPresent(Int.self, forKey: .album_id)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        owner_id = try values.decodeIfPresent(Int.self, forKey: .owner_id)
        has_tags = try values.decodeIfPresent(Bool.self, forKey: .has_tags)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        long = try values.decodeIfPresent(Double.self, forKey: .long)
        sizes = try values.decodeIfPresent([Sizes].self, forKey: .sizes)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        real_offset = try values.decodeIfPresent(Int.self, forKey: .real_offset)
    }
}

struct Sizes : Decodable {
    let height : Int?
    let url : String?
    let type : String?
    let width : Int?

    enum CodingKeys: String, CodingKey {

        case height = "height"
        case url = "url"
        case type = "type"
        case width = "width"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }

}
