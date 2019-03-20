//
//  AllListViewController.swift
//  MyCheckList
//
//  Created by macbookviet.vn on 3/18/19.
//  Copyright © 2019 macbookviet.vn. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
//    var lists = [Checklist]()
    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add placeholder data
        var list = Checklist(name: "Birthdays")
        dataModel.lists.append(list)
        
        list = Checklist(name: "Groceries")
        dataModel.lists.append(list)
        
        list = Checklist(name: "Cool Apps")
        dataModel.lists.append(list)
        
        list = Checklist(name: "To do")
        dataModel.lists.append(list)
        
        // Add placeholder item data
        for list in dataModel.lists {
            let item = ChecklistItem()
            item.text = "Item for \(list.name)"
            list.items.append(item)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        
        // Update cell information
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
    }
    
    //MARK: - Tranfer screen to Checklist viewcontroller when click cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    

    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! CheckListViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self

        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//
//        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
//        controller.delegate = self
//
//        let checklist = lists[indexPath.row]
//        controller.checklistToEdit = checklist
//        navigationController?.pushViewController(controller, animated: true)
//    }
    
    //MARK: List detail View Controller delegate
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditting checklist: Checklist) {
        if let index = dataModel.lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = checklist.name
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        // Was the back button tapped
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
}
