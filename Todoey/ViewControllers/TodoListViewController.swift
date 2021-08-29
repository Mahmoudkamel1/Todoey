//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["First Row","Second Row","Thrid Row"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. 
    }
    @IBAction func addNewTaskAction(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = alertTextField.text{
                if(text.count > 0){
                    self.itemArray.append(text)
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

