//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Bhalla on 24/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemarray = [ "SCIENCE" ,"MATHS" ,"ENGLISH", "HINDI", "SOCIAL SCIENCE" ]
    
    let defaults = UserDefaults.standard

   override func viewDidLoad() {
        super.viewDidLoad()
    
    if let items = defaults.array(forKey: "todolistarray") as? [String] {
        itemarray = items
    }
    
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemarray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
      
        {
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    @IBAction func AddButton(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            // what will happen when user clicks on add item button on our alert
            
            // item is added in table view but do not show in tableview
            self.itemarray.append(textfield.text!)
            
            
            self.defaults.set(self.itemarray, forKey: "todolistarray")
            
            // item will show only when we reload the data
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "add item"
            textfield = alerttextfield
            
            
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    
}

