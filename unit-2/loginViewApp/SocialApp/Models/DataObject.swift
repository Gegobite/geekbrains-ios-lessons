//
//  DataObject.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import UIKit

protocol DataObject {
    var name: String { get set }
    var mainImage: String { get set }
    var images: [String]? { get set }
}

extension DataObject {
    
    func getMainImage() -> UIImage?{
        return UIImage(named: mainImage) ?? nil
    }
    
    func getImages() -> [UIImage] {
        var imageNames: [String] = self.images ?? []
        imageNames.insert(self.mainImage, at: 0)
        
        var images = [UIImage]()
        for element in imageNames {
            images.append(UIImage(named: element)!)
        }
        return images
    }
}
