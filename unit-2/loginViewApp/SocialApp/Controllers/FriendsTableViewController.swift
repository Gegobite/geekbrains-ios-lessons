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
        friendsService.getByUserIdAsync(userId: AppSessionManager.currentSession.userId){ [weak self] friends in
            guard let self = self, let friends = friends else { return }
            DispatchQueue.main.async {
                self.refreshData(data: friends)
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
