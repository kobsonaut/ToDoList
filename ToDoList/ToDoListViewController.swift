//
//  ViewController.swift
//  ToDoList
//
//  Created by Kobsonauta on 11.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Climb Acouncagua", "Try skydiving", "Riding a scooter in Taiwan"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Mark - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoListTableViewCell
        cell.toDoListItemLabel.text = itemArray[indexPath.row]
        return cell
    }

    //Mark - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])


        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }



}

