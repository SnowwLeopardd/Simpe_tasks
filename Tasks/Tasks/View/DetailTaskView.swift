//
//  DetailTaskView.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/16/24.
//

import SwiftUI

struct DetailTaskView: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var path: [SingleTaskCoreData]
    
    let task: SingleTaskCoreData
    
    @State var taskToDo = ""
    @State var taskHeader = ""
    @State var taskDate = Date.now
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Header", text: $taskHeader)
            
            DatePicker("Date", selection: $taskDate, displayedComponents: .date)
                .labelsHidden()
            
            TextEditor(text: $taskToDo)
        }
        .padding(.horizontal, 16)
        .onAppear {
            taskToDo = task.todo ?? ""
            taskHeader = task.title ?? ""
            
            if let date = task.date {
                taskDate = date
            }
        }
        .onDisappear {
            coreDataManager.updateTaskCoreData(from: task, todo: taskToDo)
            coreDataManager.updateTaskCoreData(from: task, date: taskDate)
        }
    }
}

//#Preview {
//    DetailTaskView()
//}
