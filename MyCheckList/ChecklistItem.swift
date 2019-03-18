//
//  ChecklistItem.swift
//  MyCheckList
//
//  Created by macbookviet.vn on 3/16/19.
//  Copyright © 2019 macbookviet.vn. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    func toggleChecked() {
        checked = !checked
    }
}
