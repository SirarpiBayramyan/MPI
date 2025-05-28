//
//  TaskCard.swift
//  ToDoList
//
//  Created by Sirarpi Bayramyan on 28.05.25.
//

import SwiftUI
import RealmSwift

struct TaskCard: View {

    @State private var showOptions = false
    @State private var isAnimating = false
    @Binding var activeTaskId: ObjectId?

    let task: TaskItem
    var onEdit: () -> Void
    var onComplete: () -> Void


    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.pink)
                .frame(width: 8)

            VStack(alignment: .leading, spacing: 5) {
                Text(task.type.uppercased())
                    .font(.caption)
                    .foregroundColor(.pink)
                    .padding(.horizontal, 8)
                    .background(Color.pink.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Text(task.name)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("\(task.startTime) - \(task.endTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)

            Spacer()
        }
        .padding()
        .background(activeTaskId == task.id ? Color(red: 255/255, green: 207/255, blue: 207/255) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .padding(.horizontal)
        .onChange(of: activeTaskId) {
            if (activeTaskId == task.id) {
                isAnimating = true
            } else {
                isAnimating = false
            }
        }
        .rotationEffect(.degrees(isAnimating ? 1 : 0))
        .animation(isAnimating ? .easeInOut(duration: 0.08).repeatForever(autoreverses: true) : .default, value: isAnimating)

        if activeTaskId == task.id {
            HStack {
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.blue)
                }
                .padding()
                Button(action: onComplete) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.pink)
                }
                .padding()
            }
        }
    }
}

#Preview {

    @Previewable @State var activeTaskId: ObjectId? = nil
    TaskCard(
        activeTaskId: $activeTaskId,
        task: TaskItem(),
        onEdit: {},
        onComplete: {}
    )
}
