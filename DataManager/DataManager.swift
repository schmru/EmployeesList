//
//  DataManager.swift
//  EmployeesList
//
//  Created by Miha on 19/10/2024.
//

import SwiftUI

final class DataManager {
    static let shared = DataManager()
    private let context = PersistenceController.shared.container.viewContext
    
    func save(employee: Employee, into employess: FetchedResults<EmployeeDB>) {
            let employeeDB = employess.first {$0.id == employee.id} ?? EmployeeDB(context: context)
            employeeDB.id = employee.id
            employeeDB.name = employee.name
            employeeDB.lastName = employee.lastName
            employeeDB.age = employee.age
            employeeDB.gender = employee.gender
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
    
    func deleteEmployee(offsets: IndexSet, from employess: FetchedResults<EmployeeDB>) {
            offsets.map { employess[$0] }.forEach(context.delete)
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}
