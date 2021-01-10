//
//  NewsCell.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var repostsButton: UIButton!
    @IBOutlet weak var viewsCount: UIButton!
    
    private var images: [UIImage?] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNews(_ news: NewsObject){
        avatarView.image = news.authorImage
        authorLabel.text = news.author
        dateLabel.text = news.createDate.description
        images = news.images!
        imagesCollectionView.isHidden = images.isEmpty
        newsTextLabel.text = news.text
        likeControl.updateLikesCount(likes: news.likesCount)
        likeControl.updateLikeState(liked: news.isLiked)
        commentsButton.setTitle(String(news.commentsCount), for: .normal)
        repostsButton.setTitle(String(news.repostCount), for: .normal)
        viewsCount.setTitle(String(news.watchCount), for: .normal)
        
        if imagesCollectionView.isHidden == false {
            imagesCollectionView.register(UINib(nibName:"NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
            imagesCollectionView.reloadData()
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
        }
    }
}

extension NewsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.collectionImage.setImage(images[indexPath.row])
        
        cell.collectionImage.contentMode = .scaleAspectFill
        cell.collectionImage.layer.borderWidth = 1
        cell.collectionImage.layer.borderColor = UIColor.darkGray.cgColor
        cell.collectionImage.layer.cornerRadius = 10
        
        return cell
    }
}
