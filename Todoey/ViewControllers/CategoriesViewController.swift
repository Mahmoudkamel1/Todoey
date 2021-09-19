//
//  CategoriesViewController.swift
//  Todoey
//
//  Created by Macbook on 19/09/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class CategoriesViewController: UITableViewController {
    
    var Categories = [Category]()
    var lastEditedText: String = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        LoadData()
    }

    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if let text = alertTextField.text{
                if(text.count > 0){
                    let newCategory = Category(context: self.context)
                    newCategory.name = text
                    self.Categories.append(newCategory)
                    
                    self.saveItems()
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Category"
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
    func LoadData(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            
            Categories = try context.fetch(request)
            self.tableView.reloadData()
        }
        catch{
            print("Error \(error) in Retriving Data")
        }
        
    }
    
    // MARK: - Table view data source



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
