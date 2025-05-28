//
//  CalendarDay.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI

struct CalendarDay: View {
    let dayNumber: String
    let dayName: String
    var isHighlighted: Bool = false

    var body: some View {
        VStack {
            Text(dayNumber)
                .font(.headline)
                .foregroundColor(isHighlighted ? .white : .primary)
                .bold(isHighlighted)
            Text(dayName)
                .font(.caption)
                .foregroundColor(isHighlighted ? .white : .primary)
                .bold(isHighlighted)
        }
        .frame(width: 60, height: 80)
        .background(isHighlighted ? Color.pink : Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}


#Preview {
    CalendarDay(dayNumber: "7", dayName: "Sun")
}
