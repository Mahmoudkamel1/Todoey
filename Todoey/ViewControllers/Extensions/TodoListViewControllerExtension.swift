//
//  TodoListViewControllerExtension.swift
//  Todoey
//
//  Created by Macbook on 29/08/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension TodoListViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        itemArray[indexPath.row].checked = cell?.accessoryType == .checkmark ? false : true
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifier ,for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].checked ? .checkmark : .none
        return cell
    }
}
//MARK: - UI SEARCH BAR Extension
extension TodoListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            lastEditedText = ""
            LoadData()
            
        }
        else if lastEditedText != searchBar.text{
            lastEditedText = searchBar.text!
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", lastEditedText)
            request.predicate = predicate
            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            LoadData(with: request)
        }
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
}
