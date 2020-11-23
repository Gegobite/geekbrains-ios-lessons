//
//  User.swift
//  SocialApp
//
//  Created by Игорь Ершов on 07.10.2020.
//

class User : DataObject {
    var id: Int
    var login: String
    var password: String
    var name: String
    var mainImage: String
    var images: [String]?
    var friends: [Friend]?
    var groups: [Group]?
    
    init(login: String, password: String, name: String,
         mainImage: String, images: [String]? = nil,
         friends: [Friend]? = nil, groups: [Group]? = nil) {
        self.id = 1
        self.login = login
        self.password = password
        self.name = name
        self.mainImage = mainImage
        self.images = images
        self.friends = friends
        self.groups = groups
    }
}
