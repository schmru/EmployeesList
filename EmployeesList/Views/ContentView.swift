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
                ForEach(viewModel.employess, id: \.name) { employee in
                    VStack(alignment: .leading)  {
                        Text(employee.name + " " + employee.lastName)
                        Text("Age: \(employee.age)")
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
