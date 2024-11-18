//
//  TaskView.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/15/24.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var path: [SingleTaskCoreData]
    @State var taskToDo = ""
    
    var task: SingleTaskCoreData
    
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Button {
                    let updatedTask = task
                    updatedTask.completed.toggle()
                    DispatchQueue.global().async {
                        coreDataManager.updateTaskCoreData(from: updatedTask, completed: updatedTask.completed)
                    }
                } label: {
                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.completed ? .yellow : .gray)
                        .padding(.top, 5)
                }
                .buttonStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text(task.title ?? "")
                        .strikethrough(task.completed, color: .gray)
                        .foregroundColor(task.completed ? .gray : .black)
                        .font(.headline)
                    
                    Text(task.todo ?? "")
                        .lineLimit(2)
                        .foregroundColor(task.completed ? .gray : .black)
                        .font(.subheadline)
                    
                    Text((task.date == nil) ? String(localized: "JSON_doesn't_contain_date") : DateFormatter.convertDateToString(from: task.date))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            path.append(task)
        }
    }
}
