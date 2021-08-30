//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        // Do any additional setup after loading the view. 
    }
    override func viewWillAppear(_ animated: Bool) {
        if let dataArray = defaults.array(forKey: Constants.UserDefaults.TodoArrayKey) as? [Item]
        {
            itemArray = dataArray
        }
    }
    @IBAction func addNewTaskAction(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = alertTextField.text{
                if(text.count > 0){
                    let newItem = Item(tilte: text, checked: false)
                    self.itemArray.append(newItem)
                    self.defaults.set(self.itemArray, forKey: Constants.UserDefaults.TodoArrayKey)
                    self.tableView.reloadData()
                }
            }
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Item"
            alertTextField = textField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

