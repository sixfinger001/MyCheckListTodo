//
//  ViewController.swift
//  MyCheckList
//
//  Created by macbookviet.vn on 3/15/19.
//  Copyright © 2019 macbookviet.vn. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
//    var items = [ChecklistItem]()
    var checklist: Checklist!
    
    func addItemViewcontroller(_ controller: ItemDetailViewController, didFinishEditting item: ChecklistItem) {
        if let index = checklist.items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
//        saveChecklistItems()
    }
    
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
//        saveChecklistItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
        let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    
    @IBAction func addItem(){
        let newRowIndex = checklist.items.count
        
        let item = ChecklistItem()
        item.text = "I'm a new row"
        item.checked = false
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadChecklistItems()
        title = checklist.name
//        print("Data file path: \(documentDirectory())")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = checklist.items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    //Checkmark or uncheckmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        saveChecklistItems()
    }
    
    //Delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
//        saveChecklistItems()
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        label.textColor = view.tintColor
        
        if item.checked {
            label.text = "✔︎"
        }
        else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
//        label.text = item.text
        label.text = "\(item.itemID): \(item.text)"
    }
    
//    
//    func documentDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//    
//    func dataFilePath() -> URL {
//        return documentDirectory().appendingPathComponent("MyCheckList.plist")
//    }
//    
//    
//    
//    func saveChecklistItems() {
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(checklist.items)
//            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
//        } catch {
//            print("Error encoding item array")
//        }
//    }
//    
//    
//    
//    func loadChecklistItems() {
//        let path = dataFilePath()
//        if let data = try? Data(contentsOf: path){
//            let decoder = PropertyListDecoder()
//            do {
//                checklist.items = try decoder.decode([ChecklistItem].self, from: data)
//            }catch {
//                print("Error decoding item array!")
//            }
//        }
//    }
    

}

