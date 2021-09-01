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
    
    //var defaults = UserDefaults.standard
    var filePath : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        itemArray.append(Item(tilte: "- \(itemArray.count + 1) Item", checked: false))
        // Do any additional setup after loading the view. 
    }
    override func viewWillAppear(_ animated: Bool) {
        
        loadData()
    }
    @IBAction func addNewTaskAction(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = alertTextField.text{
                if(text.count > 0){
                    let newItem = Item(tilte: text, checked: false)
                    self.itemArray.append(newItem)
                    
                    self.saveItems()
                    
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
    
    func saveItems (){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.filePath!)
        }
        catch{
            print("there is an Error: \(error.localizedDescription)")
        }
    }
    func loadData(){
        if let data = try? Data(contentsOf: filePath!){
            let decoder = PropertyListDecoder()
            do{
                self.itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("there is an Error: \(error.localizedDescription)")
            }
        }
    }
}

