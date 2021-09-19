//
//  CategoriesViewControllerExtensions.swift
//  Todoey
//
//  Created by Macbook on 19/09/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension CategoriesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CategoryCellIdentifier,for: indexPath)
        cell.textLabel?.text = Categories[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemsVC = TodoListViewController()
        itemsVC.selectedCategory = Categories[indexPath.row]
        performSegue(withIdentifier: Constants.CategoriesToItemsSegueIdentifier, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = Categories[indexPath.row]
        }
        
    }

}

//MARK: - UI SEARCH BAR Extension
extension CategoriesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            lastEditedText = ""
            LoadData()
        }
        else if lastEditedText != searchBar.text{
            lastEditedText = searchBar.text!
            let request : NSFetchRequest<Category> = Category.fetchRequest()
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", lastEditedText)
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
