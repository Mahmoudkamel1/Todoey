//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: Category? {
        didSet{
            LoadData()
        }
    }
    var itemArray = [Item]()
    var lastEditedText:String = ""
    
    //var defaults = UserDefaults.standard
    var filePath : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addNewTaskAction(_ sender: UIBarButtonItem) {
        
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = alertTextField.text{
                if(text.count > 0){
                    let newItem = Item(context: self.context)
                    newItem.title = text
                    newItem.checked = false
                    newItem.parentCategory = self.selectedCategory
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
        do{
            try context.save()
        }
        catch{
            print("there is an Error: \(error.localizedDescription)")
        }
    }
    func LoadData(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let basePredicate = predicate{
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [basePredicate,categoryPredicate])
            request.predicate = compoundPredicate
        }
        else{
            request.predicate = categoryPredicate
        }
        do{
            itemArray = try context.fetch(request)
            self.tableView.reloadData()
        }
        catch{
            print("Error \(error) in Retriving Data")
        }
        
    }
}

