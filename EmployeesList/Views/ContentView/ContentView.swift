//
//  ContentView.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EmployeeDB.id, ascending: true)],
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
                .onDelete(perform: deleteItem)
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
                }
            }
        }
    }
    
    private func save(employee: Employee) {
        withAnimation {
            let employeeDB = employess.first {$0.id == employee.id} ?? EmployeeDB(context: viewContext)
            employeeDB.id = employee.id
            employeeDB.name = employee.name
            employeeDB.lastName = employee.lastName
            employeeDB.age = employee.age
            employeeDB.gender = employee.gender
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { employess[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
