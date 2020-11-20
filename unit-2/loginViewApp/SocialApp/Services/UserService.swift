//
//  UserService.swift
//  SocialApp
//
//  Created by Игорь Ершов on 07.10.2020.
//

import UIKit

class UserService{
    static func getUsers() -> [User]{
        let users: [User] = [
            User(firstName: "Ivan", secondName: "Ivanov", avatarImage: "AvatarIvanov", images: ["Ivanov1", "Ivanov2"]),
            User(firstName: "Pupka", secondName: "Pupkin", avatarImage: "AvatarPupkin", images: ["Pupkin1", "Pupkin2"])]
        
        return users
    }
    
    static func getUserAvatarImage(_ user: User) -> UIImage?{
        return UIImage(named: user.avatarImage) ?? nil
    }
    
    static func getUserImages(_ user: User) -> [UIImage]{
        var imageNames: [String] = user.images
        imageNames.insert(user.avatarImage, at: 0)
        
        var images = [UIImage]()
        for element in imageNames {
            images.append(UIImage(named: element)!)
        }
        return images
    }
}
