//
//  HorizontalCalendar.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI

struct HorizontalCalendar: View {
    let year: Int
    let month: Int

    var body: some View {
        VStack {
            HStack {
                Text(monthName(from: month))
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(generateDaysInMonth(for: month, year: year)) { day in
                        CalendarDay(dayNumber: day.day, dayName: day.name, isHighlighted: day.day == "1")
                    }
                }
                .padding()
            }
        }
    }

    func monthName(from month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))!
        return dateFormatter.string(from: date)
    }

    func generateDaysInMonth(for month: Int, year: Int) -> [Day] {
        var days = [Day]()

        let calendar = Calendar.current
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"

        for day in range {
            let dayDateComponents = DateComponents(year: year, month: month, day: day)
            let dayDate = calendar.date(from: dayDateComponents)!
            let dayName = dateFormatter.string(from: dayDate)
            days.append(Day(day: "\(day)", name: dayName))
        }

        return days
    }
}

//#Preview {
//    HorizontalCalendar()
//}
