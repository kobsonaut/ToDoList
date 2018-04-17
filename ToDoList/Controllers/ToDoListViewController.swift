//
//  ViewController.swift
//  ToDoList
//
//  Created by Kobsonauta on 11.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?

    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // loadItems()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoListTableViewCell

        if let item = toDoItems?[indexPath.row] {

            cell.toDoListItemLabel.text = item.title

            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.toDoListItemLabel.text = "No Items Added"
        }

        return cell
    }

    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }
            catch {
                print("Error saving done status, \(error)")
            }

        }

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.done = false
                        newItem.timestamp = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                catch {
                    print("Error saving realm object, \(error)")
                }
            }

            self.tableView.reloadData()

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Model Manipulations Methods

    func loadItems() {

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}

//MARK: - Search bar methods

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "timestamp", ascending: true)

        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


