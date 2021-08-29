//
//  TodoListViewControllerExtension.swift
//  Todoey
//
//  Created by Macbook on 29/08/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit

extension TodoListViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) //= .checkmark
        if(cell?.accessoryType == .checkmark){
            cell?.accessoryType = .none
        }
        else{
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}
