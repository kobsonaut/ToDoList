//
//  ViewController.swift
//  ToDoList
//
//  Created by Kobsonauta on 11.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Getting a job as an iOS Developer"
        itemArray.append(newItem)

        let newItem1 = Item()
        newItem1.title = "Climb Acouncagua"
        itemArray.append(newItem1)

        let newItem2 = Item()
        newItem2.title = "Try skydiving"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Riding a scooter in Taiwan"
        itemArray.append(newItem3)

        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    //Mark - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoListTableViewCell
        let item = itemArray[indexPath.row]
        cell.toDoListItemLabel.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    //Mark - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
    }

    //Mark - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)

            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

