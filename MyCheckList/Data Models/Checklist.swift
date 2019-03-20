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
}
