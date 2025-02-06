//
//  ContentView.swift
//  ToDos
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = TodoViewModel()
    @State private var newTaskTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(title: newTaskTitle)
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding()

                Picker("Filter", selection: $viewModel.filter) {
                    ForEach(FilterType.allCases, id: \ .self) { filter in
                        Text(filter.title).tag(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(viewModel.filteredTodos) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleCompletion(for: task)
                                }
                            Text(task.title)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("To-Do")
        }
        .onChange(of: viewModel.todos) {
            viewModel.saveTasks()
        }
    }
}

#Preview {
    ContentView()
}
