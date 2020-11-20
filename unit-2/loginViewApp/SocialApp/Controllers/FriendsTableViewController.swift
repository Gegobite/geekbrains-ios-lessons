//
//  FriendsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 09.10.2020.
//

import UIKit

class FriendsTableViewController: BaseTableViewController {

    override var dataSource: [DataObject] {
        return DataContext.instance.currentUser!.friends ?? []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FriendImagesCollectionViewController") as! FriendImagesCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        let items = getItemsInSection(section: indexPath.section)
        
        guard let item: DataObject = items[indexPath.row] else { return }
        
        vc.setDataObject(item)
    }
}
