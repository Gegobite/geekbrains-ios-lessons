//
//  NewsTableViewCell.swift
//  SocialApp
//
//  Created by Игорь Ершов on 20.10.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNews(_ news: News){
        avatarView.image = news.friend.getMainImage()
        authorLabel.text = news.friend.name
        dateLabel.text = news.createDate.description
        newsImage.image = news.image
        newsTextLabel.text = news.text
    }
}
