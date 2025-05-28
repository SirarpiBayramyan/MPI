//
//  MyTasks.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import Foundation

//struct MyTasks {

   // struct Data {
        struct Day: Identifiable {
            let id = UUID()
            let day: String
            let name: String

            init(day: String, name: String) {
                self.day = day
                self.name = name
            }
        }
   // }
//}
