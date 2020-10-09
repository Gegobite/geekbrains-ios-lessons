//
//  Group.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class Group{
    let name: String
    let avatarImage: String
    
    init(name: String, avatarImage: String) {
        self.name = name
        self.avatarImage = avatarImage
    }
}

extension Group{
    func getAvatarImage() -> UIImage?{
        return UIImage(named: avatarImage) ?? nil
    }
}
