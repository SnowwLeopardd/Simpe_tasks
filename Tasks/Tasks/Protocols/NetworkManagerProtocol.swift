//
//  Untitled.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

protocol NetworkManagerProtocol {
    func fetchMockTasksResponse() async throws -> TasksResponse
}
