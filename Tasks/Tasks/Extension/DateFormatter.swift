//
//  Untitled.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/17/24.
//
import Foundation

extension DateFormatter {
    static func convertDateToString(from date: Date?) -> String {
        guard let date = date else {
            return "Date not found"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
