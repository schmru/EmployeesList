//
//  ContentView.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

struct ContentView: View {
    private let dataManager = DataManager.shared
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EmployeeDB.name, ascending: true)],
        animation: .default)
    private var employess: FetchedResults<EmployeeDB>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(employess, id: \.self) { employee in
                    NavigationLink(destination: EmployeeView(saveFunction: {employee in save(employee: employee)},
                                                             employee: .init(from: employee))) {
                        VStack(alignment: .leading)  {
                            Text((employee.name ?? "") + " " + (employee.lastName ?? ""))
                            Text("Age: \(employee.age)")
                            Text("Gender: \(employee.gender == 1 ? "Male" : "Female")")
                        }
                    }
                }
                .onDelete(perform: deleteEmployee)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: StatisticView(employees: parseDBData())) {
                        Label("Statistic", systemImage: "info")
                    }
                }
                
                ToolbarItem {
                    NavigationLink(destination: EmployeeView(saveFunction: {employee in save(employee: employee)})) {
                        Label("Add Employee", systemImage: "plus")
                    }
                    .accessibilityIdentifier("AddButton")
                }
            }
        }
    }
    
    private func save(employee: Employee) {
        withAnimation {
            dataManager.saveOrUpdate(employee: employee, existingEmployee: employess.first {$0.id == employee.id})
        }
    }
    
    private func deleteEmployee(offsets: IndexSet) {
        withAnimation {
            dataManager.deleteEmployee(offsets: offsets, from: employess)
        }
    }
    
    private func parseDBData() -> [Employee] {
        return employess.map({ employee in
            Employee(from: employee)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
