//
//  TasksResponse.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//
import Foundation

struct TasksResponse: Decodable {
    let todos: [SingleTask]
    let total: Int
    let skip: Int
    let limit: Int
}
