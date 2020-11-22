//
//  FriendsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 09.10.2020.
//

import UIKit

class FriendsTableViewController: BaseTableViewController {

    let friendsService = AppDelegate.container.resolve(FriendsServiceDelegate.self)!
    let photosService = AppDelegate.container.resolve(PhotosServiceDelegate.self)!
    
    override var dataSource: [DataObject] {
        return DataContext.instance.currentUser!.friends ?? []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friends = friendsService.getUserFriends(userId: AppSessionManager.currentSession.userId)
        print(friends)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FriendImagesCollectionViewController") as! FriendImagesCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        let items = getItemsInSection(section: indexPath.section)
        
        guard let item = items[indexPath.row] as DataObject? else { return }
        let photos = photosService.getUserPhotos(userId: item.id)
        print(photos)
        
        vc.setDataObject(item)
    }
}
