//
//  ToDo.swift
//  ToDoList
//
//  Created by Александр Макаров on 23.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import Foundation
import RealmSwift

let realmURL = URL(string: "")!
let authServerURL = URL(string: "")!
let credencial = SyncCredentials.usernamePassword(username: "", password: "")

class ToDo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isComplete: Bool = false
    @objc dynamic var dueDate = Date()
    @objc dynamic var notes: String = ""
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleToDos() -> [ToDo] {
        return [
//            ToDo(title: "Дело 1", isComplete: false, dueDate: Date(), notes: "Заметка 1"),
//            ToDo(title: "Дело 2", isComplete: false, dueDate: Date(), notes: "Заметка 2"),
//            ToDo(title: "Дело 3", isComplete: false, dueDate: Date(), notes: "Заметка 3"),
//            ToDo(title: "Дело 4", isComplete: false, dueDate: Date(), notes: "Заметка 4"),
        ]
    }
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
