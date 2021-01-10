//
//  NewsObject.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.01.2021.
//

import Foundation
import UIKit

class NewsObject {
    var author: String = ""
    var authorImage: UIImage? = nil
    var createDate: String = ""
    var text: String = ""
    var images: [UIImage?]? = nil
    var likesCount: Int = 0
    var isLiked: Bool = false
    var commentsCount: Int = 0
    var repostCount: Int = 0
    var watchCount: Int = 0
}

extension NewsObject{
    static func fromNewsResponse(response: ResponseNews, item: NewsDto) -> NewsObject{
        let newsObject = NewsObject()
        
        newsObject.createDate = prepareDate(modelDate: item.date!)
        newsObject.text = item.text ?? ""
        newsObject.likesCount = item.likes?.count ?? 0
        newsObject.isLiked = item.likes?.user_likes == 1
        newsObject.images = getNewsImages(item: item)
        newsObject.commentsCount = item.comments?.count ?? 0
        newsObject.repostCount = item.reposts?.count ?? 0
        newsObject.watchCount = item.views?.count ?? 0
        
        let author = getAuthor(item: item, response: response)
        newsObject.author = author.name
        newsObject.authorImage = author.getMainImage()
        
        return newsObject
    }
    
    private static func prepareDate(modelDate: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM в HH:mm"
        formatter.locale = Locale(identifier: "ru")
        let date = Date(timeIntervalSince1970: Double(modelDate))
        return formatter.string(from: date)
    }
    
    private static func getNewsImages(item: NewsDto) -> [UIImage?]{
        let attachments = item.attachments?.filter{ $0.type == "photo"}.map{f -> (PhotoDto) in (f.photo!)}
        let urls = attachments?.map { s -> (Sizes) in s.sizes!.filter {$0.type == "q"}.first!}.map {$0.url}
        let originImages = urls?.map { s -> (UIImage?) in
            let url = NSURL(string: s!)! as URL
            if let imageData: NSData = NSData(contentsOf: url) {
                return UIImage(data: imageData as Data)
            }

            return nil
        }
        .filter { $0 != nil}
        
        return originImages ?? []
    }
    
    private static func getAuthor(item: NewsDto, response: ResponseNews) -> NewsAuthor {
        let object = NewsAuthor()
        
        if (item.source_id! > 0){
            let friend = response.profiles?.filter{ $0.id == item.source_id}.first
            guard let friendObj = friend else { return object }
            object.id = friendObj.id
            object.name = friendObj.name
            object.mainImage = friendObj.mainImage
        }
        else{
            let group = response.groups?.filter{ $0.id == (item.source_id! * -1)}.first
            guard let groupObj = group else { return object }
            object.id = groupObj.id
            object.name = groupObj.name
            object.mainImage = groupObj.mainImage
        }
        return object
    }
}

class NewsAuthor {
    var id: Int = 0
    var name: String = ""
    var mainImage: String = ""
    var images: [String]?
    
    func getMainImage() -> UIImage?{
        let url = NSURL(string: mainImage)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            return UIImage(data: imageData as Data)
        }

        return nil
    }
}
