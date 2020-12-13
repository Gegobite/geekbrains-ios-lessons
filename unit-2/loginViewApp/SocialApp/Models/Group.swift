//
//  Group.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class Group {
    var id: Int
    var name: String
    var mainImage: String
    var images: [String]?
    
    init(name: String, mainImage: String, images: [String]? = nil) {
        self.id = 1
        self.name = name
        self.mainImage = mainImage
        self.images = images
    }
}
