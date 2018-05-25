//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Bhalla on 24/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

    var itemarray = [item]()
    
    let defaults = UserDefaults.standard

   override func viewDidLoad() {
        super.viewDidLoad()
    
    let newitem1 = item()
    newitem1.title = "ENGLISH"
    newitem1.done = false
    itemarray.append(newitem1)
    
    let newitem2 = item()
    newitem2.title = "SCIENCE"
    newitem2.done = false
    itemarray.append(newitem2)
    
    let newitem3 = item()
    newitem3.title = "MATHS"
    newitem3.done = false
    itemarray.append(newitem3)
    
    
   if let items = defaults.array(forKey: "todolistarray") as? [item] {
        itemarray = items
    }
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        
        cell.textLabel?.text = itemarray[indexPath.row].title
        
        
        cell.accessoryType = itemarray[indexPath.row].done ? .checkmark :.none
        
//        if itemarray[indexPath.row].done == false{
//            cell.accessoryType = .none
//        }
//        else{
//            cell.accessoryType  = .checkmark
//        }
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if itemarray[indexPath.row].done == true {
            
            itemarray[indexPath.row].done = false
        }
        else {
            
            itemarray[indexPath.row].done = true
        }
        
       tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    @IBAction func AddButton(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            
            let newitem1 = item()
            newitem1.title = textfield.text!
            
            self.itemarray.append(newitem1)
            
            
            self.defaults.set(self.itemarray, forKey: "todolistarray")
            
           
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

