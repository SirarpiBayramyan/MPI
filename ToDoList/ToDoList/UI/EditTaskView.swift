//
//  EditTaskView.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI
import RealmSwift

struct EditTaskView: View {
    var task: TaskItem

    @State private var taskName: String = ""
    @State private var taskType: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()

    @Binding var showModal: Bool

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Name", text: $taskName)
                TextField("Task Type", text: $taskType)
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                DatePicker("End Time", selection: $endTime, in: startTime..., displayedComponents: .hourAndMinute)

                Button("Save Task") {
                    saveTask()
                }
            }
            .navigationBarTitle("Edit Task", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") { showModal = false })
            .onAppear {
                taskName = task.name
                taskType = task.type
                startTime = dateFormatter.date(from: task.startTime) ?? Date()
                endTime = dateFormatter.date(from: task.endTime) ?? Date()
            }
        }
    }

    private func saveTask() {
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm"
           // Update the existing task or create a new one if task is nil
           let updatedTask = TaskItem()
           updatedTask.name = taskName
           updatedTask.type = taskType
           updatedTask.startTime = formatter.string(from: startTime)
           updatedTask.endTime = formatter.string(from: endTime)

           RealmManager.shared.updateTask(task, with: updatedTask)

           // Close the modal
           showModal = false
       }
}

#Preview {
    @Previewable @State var showModal: Bool = true
    let taskItem = TaskItem()
    EditTaskView(task: taskItem, showModal: $showModal)
}
