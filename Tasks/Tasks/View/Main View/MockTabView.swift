//
//  MockTabView.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/17/24.
//

import SwiftUI

struct MockTabView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("\(coreDataManager.filteredSavedEntities.count)_tasks")
                .foregroundColor(.white)
            
            Spacer()
            
            NavigationLink(destination: AddTask()) {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background(Color(.gray))
    }
}

#Preview {
    MockTabView()
}
