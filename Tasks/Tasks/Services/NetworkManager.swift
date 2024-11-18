//
//  NetworkManager.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//
import Foundation

enum APIError: Error {
    case invalidURL
    case invalidDecoding
}

final class NetworkManager: NetworkManagerProtocol {
    func fetchMockTasksResponse() async throws -> TasksResponse {
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(TasksResponse.self, from: data)
        } catch {
            throw APIError.invalidDecoding
        }
    }
}
