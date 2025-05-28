//
//  TasksView.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI
import RealmSwift

struct TasksView: View {

    @ObservedResults(TaskItem.self) var tasks
    @State private var showingAddTaskModal = false
    @State private var showingEditTaskModal = false

    var body: some View {
        VStack {
            HorizontalCalendar(year: 2024, month: 1)
            TaskList(
                tasks: Array(tasks),
                showingAddTaskModal: $showingAddTaskModal
            )
            Spacer()
        }
        .sheet(isPresented: $showingAddTaskModal) {
            AddTaskView(showModal: $showingAddTaskModal)
        }
    }

}

#Preview {
    TasksView()
}
