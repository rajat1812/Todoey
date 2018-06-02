//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Bhalla on 24/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import UIKit
import CoreData



class ToDoListViewController: UITableViewController   {
    
    var itemarray = [Item]()   // array of custom item object

  //  goes to appdelegate & grabs the persistent container & then grab a reference(viewcontext) to the context for that persistent container
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      // create a path for storing data
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

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

        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if itemarray[indexPath.row].done == false {
//
//            itemarray[indexPath.row].done = true
//        }
//        else {
//
//            itemarray[indexPath.row].done = false
//        }
        context.delete(itemarray[indexPath.row])
        itemarray.remove(at: indexPath.row)
        
         saveitems()
    

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    
    
    @IBAction func AddButton(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in

            
            let newitem1 = Item(context: self.context)
            newitem1.title = textfield.text!
            newitem1.done = false
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
    
    
    
     func saveitems() {
        
        do{
            try context.save()
        }  catch {
            print("error encoding item array . \(error)")
        }
        
         self.tableView.reloadData()
    }
    
    

    func loaditems () {

        let request : NSFetchRequest<Item> = Item.fetchRequest()

        do{
            // application has to speak with context before we can do anything
            itemarray =  try context.fetch(request)
        } catch {
            print("\(error)")
        }
        self.tableView.reloadData()
      
    }
    

}


extension ToDoListViewController : UISearchBarDelegate , UISearchDisplayDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        // show the options related to the letter or word searched
        
        // [cd] - it shows that there is no case sensitivity in searching through a word or letter ( using uppercase or lowercase in searching)
        let predicate = NSPredicate(format: "title contains[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.sortDescriptors = sortDescriptors
        
        do{
            // application has to speak with context before we can do anything
            itemarray =  try context.fetch(request)
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        
        
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            if searchBar.text?.count == 0 {
                loaditems()
            }
    }
    
    }
}
