//
//  EmployeesListApp.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

@main
struct EmployeesListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
