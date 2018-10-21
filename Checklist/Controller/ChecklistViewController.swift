//
//  ViewController.swift
//  Checklist
//
//  Created by Dominik Wieners on 20.10.18.
//  Copyright © 2018 Dominik Wieners. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishAdding item: Checklistitem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: Checklistitem) {
        if let index = items.index(of: item){
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [Checklistitem]
    
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = items.count
        
        let item = Checklistitem()
        var titles = ["Empty todo item", "Generic todo", "Nice todo", "Awesome item"]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        item.text = titles[Int(randomNumber)]
        item.checked = true
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [Checklistitem]()
        
        let row0Item = Checklistitem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = Checklistitem()
        row1Item.text = "Brush my teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = Checklistitem()
        row2Item.text = "Do stuff"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = Checklistitem()
        row3Item.text = "Eat ice cream"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = Checklistitem()
        row4Item.text = "Walk the dog"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = Checklistitem()
        row5Item.text = "Do stuff"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = Checklistitem()
        row6Item.text = "Eat ice cream"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = Checklistitem()
        row7Item.text = "Walk the dog"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        }else if segue.identifier == "EditItem"{
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.init(named: "primary")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, at: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, at: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: Checklistitem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, at item: Checklistitem){
        let checkmark = cell.viewWithTag(1001) as! UIImageView
        if item.checked{
            checkmark.isHidden = false
        }else{
            checkmark.isHidden = true
        }
    }

}

