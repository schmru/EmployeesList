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
                    VStack(alignment: .leading)  {
                        Text((employee.name ?? "") + " " + (employee.lastName ?? ""))
                        Text("Age: \(employee.age)")
                    }
                }
                .onDelete(perform: deleteItem)
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: EmployeeView(saveFunction: {employee in addNew(employee: employee)})) {
                        Label("Add Employee", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addNew(employee: Employee) {
        withAnimation {
            let newEmployee = EmployeeDB(context: viewContext)
            newEmployee.id = employee.id
            newEmployee.name = employee.name
            newEmployee.lastName = employee.lastName
            newEmployee.age = Int16(employee.age)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
