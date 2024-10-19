//
//  EmployeesListTests.swift
//  EmployeesListTests
//
//  Created by Miha on 16/10/2024.
//

import XCTest
@testable import EmployeesList

class EmployeesListTests: XCTestCase {
    let dataManager = DataManager.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testEmployeeAdding() throws {
        let context = PersistenceController.shared.container.viewContext
        do {
            let employeesBefore = try context.fetch(EmployeeDB.fetchRequest())
            dataManager.saveOrUpdate(employee: .init(id: UUID(), name: "test", lastName: "test", age: 4, gender: 1))
            let employeesAfter = try context.fetch(EmployeeDB.fetchRequest())
            XCTAssertGreaterThan(employeesAfter.count, employeesBefore.count)
        } catch {
            print("error saving employee")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


}
