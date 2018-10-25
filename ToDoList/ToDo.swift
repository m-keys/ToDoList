//
//  ToDo.swift
//  ToDoList
//
//  Created by Александр Макаров on 23.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleToDos() -> [ToDo] {
        return [
            ToDo(title: "Дело 1", isComplete: false, dueDate: Date(), notes: "Заметка 1"),
            ToDo(title: "Дело 2", isComplete: false, dueDate: Date(), notes: "Заметка 2"),
            ToDo(title: "Дело 3", isComplete: false, dueDate: Date(), notes: "Заметка 3"),
            ToDo(title: "Дело 4", isComplete: false, dueDate: Date(), notes: "Заметка 4"),
        ]
    }
}
