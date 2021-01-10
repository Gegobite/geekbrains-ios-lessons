//
//  NewsDto.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.01.2021.
//

import Foundation

class ResponseNewsResult: Decodable {
    let response : ResponseNews?

    enum CodingKeys: String, CodingKey {

        case response = "response"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try! values.decodeIfPresent(ResponseNews.self, forKey: .response)
    }
}

class ResponseNews: Decodable {
    let items: [NewsDto]?
    let profiles: [FriendDto]?
    let groups: [GroupDto]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([NewsDto].self, forKey: .items)
        profiles = try values.decodeIfPresent([FriendDto].self, forKey: .profiles)
        groups = try values.decodeIfPresent([GroupDto].self, forKey: .groups)
        nextFrom = try values.decodeIfPresent(String.self, forKey: .nextFrom)
    }
}

class NewsDto : Decodable {
    let source_id : Int?
    let date : Int?
    let can_doubt_category : Bool?
    let can_set_category : Bool?
    let post_type : String?
    let text : String?
    let marked_as_ads : Int?
    let attachments : [Attachments]?
    let likes : Likes?
    let reposts : Reposts?
    let views : Views?
    let comments: Comments?
    let is_favorite : Bool?
    let short_text_rate : Double?
    let post_id : Int?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case source_id = "source_id"
        case date = "date"
        case can_doubt_category = "can_doubt_category"
        case can_set_category = "can_set_category"
        case post_type = "post_type"
        case text = "text"
        case marked_as_ads = "marked_as_ads"
        case attachments = "attachments"
        case post_source = "post_source"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
        case is_favorite = "is_favorite"
        case donut = "donut"
        case short_text_rate = "short_text_rate"
        case post_id = "post_id"
        case type = "type"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source_id = try values.decodeIfPresent(Int.self, forKey: .source_id)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        can_doubt_category = try values.decodeIfPresent(Bool.self, forKey: .can_doubt_category)
        can_set_category = try values.decodeIfPresent(Bool.self, forKey: .can_set_category)
        post_type = try values.decodeIfPresent(String.self, forKey: .post_type)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        marked_as_ads = try values.decodeIfPresent(Int.self, forKey: .marked_as_ads)
        attachments = try values.decodeIfPresent([Attachments].self, forKey: .attachments)
        likes = try values.decodeIfPresent(Likes.self, forKey: .likes)
        reposts = try values.decodeIfPresent(Reposts.self, forKey: .reposts)
        views = try values.decodeIfPresent(Views.self, forKey: .views)
        comments = try values.decodeIfPresent(Comments.self, forKey: .views)
        is_favorite = try values.decodeIfPresent(Bool.self, forKey: .is_favorite)
        short_text_rate = try values.decodeIfPresent(Double.self, forKey: .short_text_rate)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
}

class Likes : Decodable {
    let count : Int?
    let user_likes : Int?
    let can_like : Int?
    let can_publish : Int?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case user_likes = "user_likes"
        case can_like = "can_like"
        case can_publish = "can_publish"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        user_likes = try values.decodeIfPresent(Int.self, forKey: .user_likes)
        can_like = try values.decodeIfPresent(Int.self, forKey: .can_like)
        can_publish = try values.decodeIfPresent(Int.self, forKey: .can_publish)
    }
}

class Views : Decodable {
    let count : Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

class Attachments : Decodable {
    let type : String?
    let photo : PhotoDto?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case photo = "photo"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        photo = try values.decodeIfPresent(PhotoDto.self, forKey: .photo)
    }
}

class Reposts : Decodable {
    let count : Int?
    let user_reposted : Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case user_reposted = "user_reposted"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        user_reposted = try values.decodeIfPresent(Int.self, forKey: .user_reposted)
    }
}

class Comments : Decodable {
    let count : Int?
    let can_post : Int?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case can_post = "can_post"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        can_post = try values.decodeIfPresent(Int.self, forKey: .can_post)
    }

}
