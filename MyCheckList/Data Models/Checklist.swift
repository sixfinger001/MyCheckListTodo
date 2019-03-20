//
//  Checklist.swift
//  MyCheckList
//
//  Created by macbookviet.vn on 3/19/19.
//  Copyright © 2019 macbookviet.vn. All rights reserved.
//

import UIKit
import Foundation

class Checklist: NSObject, Codable {

    var name = ""
    var items = [ChecklistItem]()
    init(name: String){
        self.name = name
        super.init()
    }
    
//    func countUncheckedItems() -> Int {
//        var count = 0
//        for item in items where !item.checked {
//            count += 1
//        }
//        return count
//    }
    
    func countUncheckedItems() -> Int {
        return items.reduce(0) {
            cnt, item in cnt + (item.checked ? 0 : 1)
        }
    }
}
