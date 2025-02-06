//
//  TodoItem.swift
//  ToDos
//
//  Created by Sirarpi Bayramyan on 06.02.25.
//

import Foundation

struct TodoItem: Identifiable, Codable, Equatable {

    var id = UUID()
    var title: String
    var isCompleted: Bool
    
}
