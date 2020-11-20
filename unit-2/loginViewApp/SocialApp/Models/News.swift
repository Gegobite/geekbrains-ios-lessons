//
//  News.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.10.2020.
//

import UIKit

class News{
    let friend: Friend
    let createDate: Date
    let text: String
    let image: UIImage?
    
    init(friend: Friend, createDate: Date, text: String, image: UIImage?){
        self.friend = friend
        self.createDate = createDate
        self.image = image
        self.text = text
    }
}
