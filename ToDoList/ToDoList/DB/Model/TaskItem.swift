//
//  TaskItem.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import Foundation
import RealmSwift

class TaskItem: Object, Identifiable {

    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var type: String = ""
    @Persisted var startTime: String = ""
    @Persisted var endTime: String = ""
    
}
