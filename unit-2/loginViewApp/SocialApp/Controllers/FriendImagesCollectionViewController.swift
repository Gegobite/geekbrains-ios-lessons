//
//  FriendImagesCollectionViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 09.10.2020.
//

import UIKit

private let reuseIdentifier = "friendImagesCell"

class FriendImagesCollectionViewController: UICollectionViewController {

    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(FriendImagesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func setDataObject(_ dataObject: DataObject) {
        self.images = dataObject.getImages()
        self.title = dataObject.name
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
        
//        let imageview:UIImageView=UIImageView(frame: CGRect(x: 50, y: 50, width: 150, height: 150));
//
//                
//                imageview.image = cellImage
//
//                cell.contentView.addSubview(imageview)
        
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
        
        vc.setup(images, selectedImage: selectedItem)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
