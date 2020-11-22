//
//  GroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class GroupsTableViewController: BaseTableViewController {
    
    let groupsService = AppDelegate.container.resolve(GroupsServiceDelegate.self)!
    
    override var dataSource: [DataObject] {
        return DataContext.instance.currentUser!.groups ?? []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let groups = groupsService.getUserGroups(userId: AppSessionManager.currentSession.userId)
        print(groups)
    }
}
