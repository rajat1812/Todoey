//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Bhalla on 24/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import UIKit



class ToDoListViewController: UITableViewController  {
    
    var itemarray = [item]()   // array of custom item object
 
   
    // create a file path to the document's folder &
    let DataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")

  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    
    print(DataFilePath!)
    
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
    
    
    loaditems()
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemarray.count
    }

    
  /**  MARK :  TABLE VIEW DELEGATE METHODS  **/
    
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
        
        if itemarray[indexPath.row].done == false {
            
            itemarray[indexPath.row].done = true
        }
        else {
            
            itemarray[indexPath.row].done = false
        }
        
         saveitems()
    

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    
    
    @IBAction func AddButton(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            
            let newitem1 = item()
            newitem1.title = textfield.text!
            
            self.itemarray.append(newitem1)
            
            self.saveitems()
        }
        
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "add item"
            textfield = alerttextfield
            
            
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    // convert array of items into plist
    
    func saveitems() {
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try? encoder.encode(itemarray)
            try data?.write(to: DataFilePath!)
        }  catch {
            print("error encoding item array . \(error)")
        }
        
         tableView.reloadData()
    }
    
    
    // convert plist into array of item
    
    func loaditems () {
       if  let data = try? Data(contentsOf: DataFilePath!) {
        do{
            let decoder = PropertyListDecoder()
            itemarray = try decoder.decode([item].self, from: data)
        } catch  {
            print("\(error)")
        }
        }
    }
}

