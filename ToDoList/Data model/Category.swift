//
//  Category.swift
//  ToDoList
//
//  Created by Kobsonauta on 17.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
