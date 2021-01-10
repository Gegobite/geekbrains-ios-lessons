//
//  GroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class GroupsTableViewController: BaseTableViewController<GroupDto> {
    
    let groupsService = AppDelegate.container.resolve(GroupsServiceDelegate.self)!
    
//    override var dataSource: [DataObject] {
//        return DataContext.instance.currentUser!.groups ?? []
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        DispatchQueue.main.async {
            let groups = self.groupsService.getByUserIdFromLocal(userId: AppSessionManager.currentSession.userId)
            if (groups.isEmpty){
                self.refresh(sender: self)
            }
            else {
               // self.refreshData(data: groups)
            }
        }
    }
    
    @objc func refresh(sender:AnyObject)
    {
        groupsService.getGroupsByUserIdAsync(userId: AppSessionManager.currentSession.userId){ [weak self] groups in
            guard let self = self, let groups = groups else { return }
            DispatchQueue.main.async {
                self.groupsService.addOrUpdate(groups: groups)
             //   self.refreshData(data: groups)
                
                self.refreshControl?.endRefreshing()
            }
        }
    }
}
