//
//  ContentViewModel.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var employess: [Employee] = []
    
    func addNew(emloyee: Employee) {
        employess.append(emloyee)
    }
}
