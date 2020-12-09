//
//  FriendsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 09.10.2020.
//

import UIKit

class FriendsTableViewController: BaseTableViewController {

    let friendsService = AppDelegate.container.resolve(FriendsServiceDelegate.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        DispatchQueue.main.async {
            let friends = self.friendsService.getByUserIdFromLocal(userId: AppSessionManager.currentSession.userId)
            if (friends.isEmpty){
                self.refresh(sender: self)
            }
            else {
                self.refreshData(data: friends)
            }
        }
    }
    
    @objc func refresh(sender:AnyObject)
    {
        friendsService.getByUserIdAsync(userId: AppSessionManager.currentSession.userId){ [weak self] friends in
            guard let self = self, let friends = friends else { return }
            DispatchQueue.main.async {
                self.friendsService.addOrUpdate(friends: friends)
                self.refreshData(data: friends)
                
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FriendImagesCollectionViewController") as! FriendImagesCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        let items = getItemsInSection(section: indexPath.section)
        
        guard let item = items[indexPath.row] as DataObject? else { return }
        
        vc.setDataObject(item)
    }
}
