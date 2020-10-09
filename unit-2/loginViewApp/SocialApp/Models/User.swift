//
//  User.swift
//  SocialApp
//
//  Created by Игорь Ершов on 07.10.2020.
//

class User{
    let firstName: String
    let secondName: String
    let avatarImage: String
    let images: [String]
    
    init(firstName: String, secondName: String, avatarImage: String, images: [String]) {
        self.firstName = firstName
        self.secondName = secondName
        self.avatarImage = avatarImage
        self.images = images
    }
}
