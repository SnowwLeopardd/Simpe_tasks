//
//  TaskView.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/15/24.
//

import SwiftUI

struct TaskView: View {
    
    var task: SingleTaskCoreData
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
//                let updatedTask = task
//                updatedTask.completed.toggle()
//                coreDataManager.updateTaskCoreData(from: updatedTask, completed: updatedTask.completed)
            } label: {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.completed ? .yellow : .gray)
                    .padding(.top, 5)
            }
            
            VStack(alignment: .leading) {
                Text(task.title ?? "")
                    .strikethrough(task.completed, color: .gray)
                    .foregroundColor(task.completed ? .gray : .primary)
                    .font(.headline)
                
                Text(task.todo ?? "")
                    .lineLimit(2)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text(task.date ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

//#Preview {
//    let coreDataManager: CoreDataManagerProtocol = CoreDataManager()
//    let task = coreDataManager.fetchData().first!
//    
//    TaskView(task: task)
//}
