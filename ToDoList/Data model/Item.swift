//
//  Item.swift
//  ToDoList
//
//  Created by Kobsonauta on 17.04.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var timestamp: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
