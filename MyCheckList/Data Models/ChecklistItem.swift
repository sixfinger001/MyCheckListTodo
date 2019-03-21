//
//  ChecklistItem.swift
//  MyCheckList
//
//  Created by macbookviet.vn on 3/16/19.
//  Copyright © 2019 macbookviet.vn. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = Int()
    func toggleChecked() {
        checked = !checked
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
}
