//
//  TaskList.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI
import RealmSwift

struct TaskList: View {

    let tasks: [TaskItem]
    @State private var activeTaskId: ObjectId?
    @Binding var showingAddTaskModal: Bool
    @State var showingEditTaskModal: Bool = false
    @State var selectedTask: TaskItem = TaskItem()

    var body: some View {
        VStack {
            HStack {
                Text("My Tasks")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
                Button(action: {
                    showingAddTaskModal = true
                    activeTaskId = nil
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.pink)
                }
                .padding()
            }

            if tasks.isEmpty {
                emptyTasks
            } else {
                fullTasks
            }
        }
        .onTapGesture {
            activeTaskId = nil
        }
        .sheet(isPresented: $showingEditTaskModal) {
            EditTaskView(task: selectedTask, showModal: $showingEditTaskModal)
        }
    }


    var emptyTasks: some View {
        Text("Your work for the day is done.")
            .font(.headline)
            .bold()
            .padding()
    }


    var fullTasks: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(tasks) { task in
                    TaskCard(
                        activeTaskId: $activeTaskId,
                        task: task,
                        onEdit: {
                            selectedTask.id = task.id
                            selectedTask.name = task.name
                            selectedTask.type = task.type
                            selectedTask.startTime = task.startTime
                            selectedTask.endTime = task.endTime
                            activeTaskId = nil
                            showingEditTaskModal = true
                        },
                        onComplete: {
                            activeTaskId = nil
                            RealmManager.shared.deleteTask(task)
                        }
                    )
                    .onLongPressGesture {
                        activeTaskId = (activeTaskId == task.id) ? nil : task.id
                    }
                }
            }
            .padding()
        }
    }


}




