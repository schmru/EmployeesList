//
//  ContentView.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.employess, id: \.self) { employee in
                    VStack(alignment: .leading)  {
                        Text(employee.name + " " + employee.lastName)
                        Text("Age: \(employee.age)")
                    }
                }
                .onDelete(perform: viewModel.deleteItem)
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: EmployeeView(saveFunction: {employee in viewModel.addNew(emloyee: employee)})) {
                        Label("Add Employee", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
