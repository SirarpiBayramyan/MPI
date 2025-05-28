//
//  RealmManager.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private var realm: Realm
    
    
    private init() {
        do {
            realm = try Realm()
        } catch let error {
            fatalError("Realm can't be initialized: \(error.localizedDescription)")
        }
    }
    
    func addTask(_ task: TaskItem) {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch let error {
            print("Error adding task: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(_ task: TaskItem) {
        do {
            // Fetch the same task from the current Realm instance
            if let taskToDelete = realm.object(ofType: TaskItem.self, forPrimaryKey: task.id) {
                try realm.write {
                    realm.delete(taskToDelete)
                }
            } else {
                print("Task not found or already deleted")
            }
        } catch let error {
            print("Error deleting task: \(error.localizedDescription)")
        }
    }
    
    // Function to edit a Task in Realm
    func updateTask(_ task: TaskItem, with newTask: TaskItem) {
        do {
            // Fetch the same task from the current Realm instance
            if let taskToUpdate = realm.object(ofType: TaskItem.self, forPrimaryKey: task.id) {
                try realm.write {
                    taskToUpdate.name = newTask.name
                    taskToUpdate.type = newTask.type
                    taskToUpdate.startTime = newTask.startTime
                    taskToUpdate.endTime = newTask.endTime
                }
            } else {
                print("No Task with id \(task.id) found")
            }
        } catch let error {
            print("Error updating task: \(error.localizedDescription)")
        }
    }
    
}

