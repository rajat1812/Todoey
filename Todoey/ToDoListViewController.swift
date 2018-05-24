//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Bhalla on 24/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
     let itemarray = [ "SCIENCE" ,"MATHS" ,"ENGLISH", "HINDI", "SOCIAL SCIENCE" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    
}

