//
//  Friend.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import Foundation
class Friend: DataObject {
    var id: Int
    var name: String
    var mainImage: String
    var images: [String]?
    var friends: [Friend]?
    var groups: [Group]?
    
    init(name: String, mainImage: String, images: [String]? = nil,
         friends: [User]? = nil, groups: [Group]? = nil) {
        self.id = 1
        self.name = name
        self.mainImage = mainImage
        self.images = images
        self.groups = groups
    }
}
