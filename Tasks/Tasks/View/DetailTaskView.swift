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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.date ?? "")
            
            TextEditor(text: $taskToDo)
        }
        .padding(.horizontal, 16)
        .navigationTitle(task.title ?? "")
        .onAppear {
            taskToDo = task.todo ?? ""
        }
        .onDisappear {
            coreDataManager.updateTaskCoreData(from: task, todo: taskToDo)
        }
    }
}

//#Preview {
//    DetailTaskView()
//}
