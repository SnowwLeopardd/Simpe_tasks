//
//  ContentView.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    @StateObject var coreDataManagerVM = CoreDataManager()
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(coreDataManagerVM.savedEntities) { task in
                        Button {
                            print("Button clicked")
                        } label: {
                            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.completed ? .yellow : .gray)
                                .padding(.top, 5)
                        }
                        .onTapGesture {
                            let updatedTask = task
                            updatedTask.completed.toggle()
                            coreDataManagerVM.updateTaskCoreData(from: updatedTask, completed: updatedTask.completed)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    Task {
                        await createInitialData()
                    }
                }
                .navigationTitle("some text")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            let task = SingleTask(id: 1, todo: "test", completed: true, userId: 2)
                            coreDataManagerVM.createSingleTaskCoreData(from: task)
                        } label: {
                            Text("Add")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            coreDataManagerVM.fetchData()
                        } label: {
                            Text("fetch")
                        }
                    }
                }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.forEach { index in
            let taskToDelete = coreDataManagerVM.savedEntities[index]
            coreDataManagerVM.delete(taskToDelete)
        }
    }
    
    private func createInitialData() async {
        if coreDataManagerVM.savedEntities.isEmpty {
            do {
                let taskResponse = try await networkManager.fetchMockTasksResponse()
                
                for task in taskResponse.todos {
                    coreDataManagerVM.createSingleTaskCoreData(from: task)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
