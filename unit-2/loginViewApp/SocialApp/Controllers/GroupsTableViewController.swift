//
//  GroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 10.10.2020.
//

import UIKit

class GroupsTableViewController: BaseTableViewController {

    override var dataSource: [DataObject] {
        return DataContext.instance.currentUser!.groups ?? []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
