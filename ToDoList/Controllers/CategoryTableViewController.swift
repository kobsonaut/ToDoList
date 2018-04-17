//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Kobsonauta on 12.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()

    var toDoCategories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCategories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.textLabel?.text = toDoCategories?[indexPath.row].name ?? "No categories added."

        return cell
    }

    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = toDoCategories?[indexPath.row]
        }
    }

    //MARK: - Data Manipulation Methods

    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving realm category, \(error)")
        }
        tableView.reloadData()
    }

    func loadCategories() {

        toDoCategories = realm.objects(Category.self)

        tableView.reloadData()
    }

    //MARK: - Delete Data From Swipe

    override func updateModel(at indexPath: IndexPath) {
        if let category = self.toDoCategories?[indexPath.row] {

            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            }
            catch {
                print("Error deleting object, \(error)")
            }
        }
    }


}
