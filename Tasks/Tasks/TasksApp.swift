//
//  TasksApp.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

import SwiftUI

@main
struct TasksApp: App {
    @StateObject private var coreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coreDataManager)
        }
    }
}
