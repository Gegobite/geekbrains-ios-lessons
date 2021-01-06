//
//  FriendImagesCollectionViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 09.10.2020.
//

import UIKit

private let reuseIdentifier = "friendImagesCell"

class FriendImagesCollectionViewController: UICollectionViewController {
    
    let photosService = AppDelegate.container.resolve(PhotosServiceDelegate.self)!
    var images: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDataObject(_ dataObject: DataObject) {
        self.title = dataObject.name
        
        photosService.getByUserIdAsync(userId: dataObject.id) { [weak self] photos in
            guard let self = self, let photos = photos else {return}
            
            let urls = photos.map { s -> (Sizes) in s.sizes!.filter {$0.type == "q"}.first!}.map {$0.url}
            let originImages = urls.map { s -> (UIImage?) in
                let url = NSURL(string: s!)! as URL
                if let imageData: NSData = NSData(contentsOf: url) {
                    return UIImage(data: imageData as Data)
                }

                return nil
            }
            .filter { $0 != nil}
            
            DispatchQueue.main.async {
                self.images = originImages
                self.collectionView.reloadData()
            }
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendImagesCollectionViewCell
    
        let cellImage = images[indexPath.item];
        
        cell.imageView.image = cellImage
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 414)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FriendImagesViewController") as! FriendImagesViewController
       // self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true, completion: nil)
        
        let selectedItem = images[indexPath.item]
        
        vc.setup(images, selectedImage: selectedItem!)
    }

}
