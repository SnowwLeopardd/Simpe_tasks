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
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State private var path = [SingleTaskCoreData]()
    
    var body: some View {
        NavigationStack(path: $path) {
                List {
                    ForEach(coreDataManager.filteredSavedEntities) { task in
                        TaskView(path: $path , task: task)
                            .contextMenu {
                                Button {
                                    path.append(task)
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(role: .destructive) {
                                    coreDataManager.delete(task)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
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
                .navigationDestination(for: SingleTaskCoreData.self, destination: { task in
                    DetailTaskView(path: $path, task: task)
                })
                .navigationTitle(String(localized: "Tasks"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: AddTask()) {
                            Text(String(localized:"Add_task"))
                        }
                    }
                }
                .searchable(text: $coreDataManager.searchText)
            
            MockTabView()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.forEach { index in
            let taskToDelete = coreDataManager.savedEntities[index]
            coreDataManager.delete(taskToDelete)
        }
    }
    
    private func createInitialData() async {
        if coreDataManager.savedEntities.isEmpty {
            do {
                let taskResponse = try await networkManager.fetchMockTasksResponse()
                
                for task in taskResponse.todos {
                    coreDataManager.createSingleTaskCoreData(from: task)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
