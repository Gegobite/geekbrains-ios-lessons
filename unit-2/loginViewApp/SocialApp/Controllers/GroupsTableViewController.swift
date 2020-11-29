//
//  GroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class GroupsTableViewController: BaseTableViewController {
    
    let groupsService = AppDelegate.container.resolve(GroupsServiceDelegate.self)!
    
//    override var dataSource: [DataObject] {
//        return DataContext.instance.currentUser!.groups ?? []
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsService.getGroupsByUserIdAsync(userId: AppSessionManager.currentSession.userId){ [weak self] groups in
            guard let self = self, let groups = groups else { return }
            DispatchQueue.main.async {
                self.refreshData(data: groups)
            }
        }
    }
}
