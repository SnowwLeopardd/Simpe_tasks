//
//  AddTask.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

import SwiftUI

struct AddTask: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isFocused: Bool
    
    @State private var taskTitleTextField = ""
    @State private var taskDescriptionTextField = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(String(localized: "Add_task"))
                    .font(.headline)
                    .lineSpacing(22)
                    .foregroundColor(.black)
            }
            .padding(.top, 20)
            .padding(.bottom, 22)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(String(localized:"Enter_title_of_the_task"))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                
                TextField(String(localized:"super_important_title"), text: $taskTitleTextField)
                    .focused($isFocused)
                    .font(.headline)
                    .padding()
                    .foregroundColor(Color(.black))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.black), lineWidth: 2))
            }
            .padding(.bottom, 22)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(String(localized:"Enter_your_task"))
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                TextField(String(localized:"Description_of_the_task"), text: $taskDescriptionTextField)
                    .font(.headline)
                    .padding()
                    .foregroundColor(Color(.black))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.black), lineWidth: 2))
            }
            
            Spacer()
            
            Button(action: {
                let task = SingleTask(
                    id: coreDataManager.savedEntities.count + 1,
                    todo: taskDescriptionTextField,
                    completed: false,
                    userId: Int.random(in: 1...1000000000)
                )
                
                coreDataManager.createSingleTaskCoreData(
                    from: task,
                    title: taskTitleTextField,
                    date: .now
                    )
                
                dismiss()
            }) {
                Text(String(localized:"Add_task"))
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 30)
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AddTask()
}
