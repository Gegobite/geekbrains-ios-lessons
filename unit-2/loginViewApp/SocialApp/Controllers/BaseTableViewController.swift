//
//  SearchGroupsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Ершов on 19.10.2020.
//

import UIKit

class BaseTableViewController: UITableViewController, UISearchBarDelegate {

    var dataSource: [DataObject] { return [] }
    
    private var filteredData: [DataObject]!
    private var searchBarWrapperView: UIView!
    private var searchBar: UISearchBar!
    private var dataSourceIndex: [String] {
            get {
                var index: [String] = []
                for item in filteredData {
                    index.append(String(item.name.first!))
                }
                return Array(Set(index)).sorted()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = dataSource
        
        tableView.register(UINib(nibName: "CommonTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonCell")
        
        searchBarWrapperView = UIView(frame: CGRect(x: 0, y: 25, width: tableView.frame.width, height: 54))
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBarWrapperView.addSubview(searchBar)

        tableView.tableHeaderView = searchBarWrapperView
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
        return filteredData.filter {String($0.name.first!) == dataSourceIndex[section]}
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? dataSource :
            dataSource.filter { (item: DataObject) -> Bool in
                return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
                
        tableView.reloadData()
    }
}
