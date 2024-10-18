//
//  Employee.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import Foundation

struct Employee {
    var id: UUID
    var name: String
    var lastName: String
    var age: Int16
    
    init(id: UUID,
         name: String,
         lastName: String,
         age: Int16)
    {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.age = age
    }
    
    init(from employeeDB: EmployeeDB) {
        self.id = employeeDB.id ?? UUID()
        self.name = employeeDB.name ?? ""
        self.lastName = employeeDB.lastName ?? ""
        self.age = employeeDB.age
    }
}
