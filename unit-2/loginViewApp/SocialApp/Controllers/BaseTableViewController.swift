//
//  SearchGroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import UIKit
import RealmSwift

class BaseTableViewController<TEntity : DataObject>: UITableViewController, UISearchBarDelegate {

    var dataSource: Results<TEntity>?
    private var searchBarWrapperView: UIView!
    private var searchBar: UISearchBar!
    private var dataSourceIndex: [String] {
            get {
                var index: [String] = []
                dataSource?.forEach {
                    index.append(String($0.name.first!))
                }
                return Array(Set(index)).sorted()
                
            }
        }
    
    private var sections: [(index: Int, name: String, items: Results<TEntity>)]?
    private var tokens: [NotificationToken] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
        
        tableView.register(UINib(nibName: "CommonTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonCell")
        
        searchBarWrapperView = UIView(frame: CGRect(x: 0, y: 25, width: tableView.frame.width, height: 54))
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBarWrapperView.addSubview(searchBar)

        tableView.tableHeaderView = searchBarWrapperView
    }
    
    func refreshData(data: [TEntity]){
        tableView.reloadData()
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        dataSource = realm.objects(TEntity.self)
        sections = []
        tokens = []
        var index = 0
        dataSourceIndex.forEach {
            let items = dataSource!.filter("name BEGINSWITH %@", $0)
            sections?.append((index, $0, items))
            index += 1
        }
        
        sections?.forEach{ section in
            let token = section.items.observe{ [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: section.index) }),
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: section.index)}),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: section.index) }),
                                         with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
            
            tokens.append(token)
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSourceIndex.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getItemsInSection(section: section).count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.layer.backgroundColor = tableView.layer.backgroundColor
        view.layer.opacity = 0.5
        let label = UILabel(frame: CGRect(x: 20, y: 5, width: 50, height: 20))
        label.text = String(dataSourceIndex[section])
        view.addSubview(label)
        return view
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSourceIndex
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as! CommonTableViewCell
        let items = getItemsInSection(section: indexPath.section)
        let item = items[indexPath.row]
        
        cell.avatarView.image = item.getMainImage()
        cell.nameLabel.text = item.name
        return cell
    }
    
    func getItemsInSection(section: Int) -> [DataObject]{
        return dataSource!.filter {String($0.name.first!) == dataSourceIndex[section]}
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (!searchText.isEmpty){
            dataSource = dataSource?.filter("name CONTAINS[c] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
            tableView.reloadData()
        }
        else{
            pairTableAndRealm()
        }
    }
}
