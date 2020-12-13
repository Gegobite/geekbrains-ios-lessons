//
//  DataObject.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import UIKit
import RealmSwift

protocol DataObject : Object {
    var id: Int { get set }
    var name: String { get set }
    var mainImage: String { get set }
    var images: [String]? { get set }
}

extension DataObject {
    
    func getMainImage() -> UIImage?{
        let url = NSURL(string: mainImage)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            return UIImage(data: imageData as Data)
        }

        return nil
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
