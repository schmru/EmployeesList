//
//  EmployeesListUITests.swift
//  EmployeesListUITests
//
//  Created by Miha on 16/10/2024.
//

import XCTest

class EmployeesListUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testIfAddButtonExists() throws {
        let searchButton = app.buttons["AddButton"]
        XCTAssertTrue(searchButton.exists)
    }
}
