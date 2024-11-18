//
//  Untitled.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

import CoreData

final class CoreDataManager: ObservableObject {
    
    let mainContext: NSManagedObjectContext
    
    @Published var savedEntities: [SingleTaskCoreData] = []
    @Published var searchText: String = ""
    
    var filteredSavedEntities: [SingleTaskCoreData] {
        guard !searchText.isEmpty else { return savedEntities }
        
        return savedEntities.filter { savedEntity in
            savedEntity.todo?.lowercased().contains(searchText.lowercased()) ?? false ||
            savedEntity.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
        fetchData()
    }
    
    // MARK: - Core Data saving support
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
                DispatchQueue.main.async {
                    self.fetchData()
                }
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD operators
    private func fetchData() {
        let fetchRequest = SingleTaskCoreData.fetchRequest()
        
        do {
            savedEntities = try mainContext.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private func fetchTask(by id: UUID) -> SingleTaskCoreData? {
        let fetchRequest: NSFetchRequest<SingleTaskCoreData> = SingleTaskCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch task: \(error)")
            return nil
        }
    }
    
    func createSingleTaskCoreData(from taskAPI: SingleTask, title: String? = nil, date: Date? = nil) {
        let singleTask = SingleTaskCoreData(context: mainContext)
        
        singleTask.apiId = Int64(taskAPI.id)
        singleTask.id = UUID()
        singleTask.completed = taskAPI.completed
        singleTask.todo = taskAPI.todo
        singleTask.userId = Int64(taskAPI.userId)
        singleTask.title = title ?? String(localized: "JSON_doesn't_contain_title")
        singleTask.date = date
        saveContext()
    }
    
    func delete(_ task: SingleTaskCoreData) {
        mainContext.delete(task)
        saveContext()
    }
    
    func updateTaskCoreData(from task: SingleTaskCoreData, completed: Bool) {
        if let taskToUpdate = fetchTask(by: task.id ?? UUID()) {
            taskToUpdate.completed = completed
            saveContext()
        }
    }
    
    func updateTaskCoreData(from task: SingleTaskCoreData, todo: String?) {
        if let taskToUpdate = fetchTask(by: task.id ?? UUID()) {
            taskToUpdate.todo = todo
            saveContext()
        }
    }
    
    func updateTaskCoreData(from task: SingleTaskCoreData, title: String?) {
        if let taskToUpdate = fetchTask(by: task.id ?? UUID()) {
            taskToUpdate.title = title
            saveContext()
        }
    }
    
    func updateTaskCoreData(from task: SingleTaskCoreData, date: Date?) {
        if let taskToUpdate = fetchTask(by: task.id ?? UUID()) {
            taskToUpdate.date = date
            saveContext()
        }
    }
}
