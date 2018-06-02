//
//  Item.swift
//  Todoey
//
//  Created by Rajat Bhalla on 26/05/18.
//  Copyright © 2018 Rajat Bhalla. All rights reserved.
//

import Foundation

class item : Encodable , Decodable {     // we can use Codable INTERAD OF Encodable & Decodable
    
    var title : String = ""
    var done : Bool = false                               
}
// Encodable : it means that item type is now able to encode itself into a plist or into a json & for that all properties of class must be in standard form
