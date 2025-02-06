//
//  TodoViewModel.swift
//  ToDos
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import Foundation

enum FilterType: CaseIterable {
    case all, completed, uncompleted

    var title: String {
        switch self {
        case .all:
            "All"
        case .completed:
            "Completed"
        case .uncompleted:
            "Un Completed"
        }
    }
}

class TodoViewModel: ObservableObject {

    @Published var todos: [TodoItem] = []
    @Published var filter: FilterType = .all

    private let userDefaultsKey = "todo_list"

    init() {
        loadTasks()
    }

    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedTasks = try? JSONDecoder().decode([TodoItem].self, from: savedData) {
            todos = decodedTasks
        }
    }

    func addTask(title: String) {
        let newTask = TodoItem(title: title, isCompleted: false)
        todos.append(newTask)
    }

    func deleteTask(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == task.id }) {
            todos[index].isCompleted.toggle()
        }
    }

    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }

    var filteredTodos: [TodoItem] {
        switch filter {
        case .all:
            return todos
        case .completed:
            return todos.filter { $0.isCompleted }
        case .uncompleted:
            return todos.filter { !$0.isCompleted }
        }
    }

    
}
