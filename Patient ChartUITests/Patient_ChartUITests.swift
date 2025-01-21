//
//  Patient_ChartUITests.swift
//  Patient ChartUITests
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import XCTest

class Patient_ChartUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func makePatient(firstName: String, lastName: String, height: String, weight: String) {
        let app = XCUIApplication()
        app.buttons["addPatientButton"].tap()
        app.textFields["firstNameField"].tap()
        app.textFields["firstNameField"].typeText(firstName)
        app.textFields["lastNameField"].tap()
        app.textFields["lastNameField"].typeText(lastName)
        app.textFields["heightField"].tap()
        app.textFields["heightField"].typeText(height)
        app.textFields["weightField"].tap()
        app.textFields["weightField"].typeText(weight)
        app.buttons["saveButton"].tap()
    }
    
    @MainActor
    func makeMedication(medicationName: String, medicationDose: String, medicationRoute: String, medicationFrequency: Int, medicationDuration: Int) {
        let app = XCUIApplication()
        app.buttons["prescribeMedicationButton"].tap()
        app.textFields["medicationNameField"].tap()
        app.textFields["medicationNameField"].typeText(medicationName)
        app.textFields["medicationDoseField"].tap()
        app.textFields["medicationDoseField"].typeText(medicationDose)
        app.textFields["medicationRouteField"].tap()
        app.textFields["medicationRouteField"].typeText(medicationRoute)
        app.textFields["medicationFrequencyField"].tap()
        app.textFields["medicationFrequencyField"].typeText(String(medicationFrequency))
        app.textFields["medicationDurationField"].tap()
        app.textFields["medicationDurationField"].typeText(String(medicationDuration))
        app.buttons["saveMedicationButton"].tap()
    }

    @MainActor
    func testPatientListView() throws {
        let app = XCUIApplication()
        app.launch()
        makePatient(firstName: "Boba", lastName: "Fett", height: "180", weight: "170")
        // Test the main Patient List View
        
        // Verify that the Patients navigation title exists
        let exists = app.navigationBars["Patients"].waitForExistence(timeout: 5)
        XCTAssertTrue(app.staticTexts["patientName_Fett_Boba"].exists)
        
        // Test the search functionality
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field is missing.")
        
        searchField.tap()
        searchField.typeText("Doe")
        
        let filteredCell = app.cells.staticTexts["Doe, John (90 years)"]
        XCTAssertTrue(filteredCell.exists, "Search filter is not working correctly for 'Doe'.")

        // Test tapping a patient entry
        filteredCell.tap()
        XCTAssertTrue(app.navigationBars["Patient Details"].exists, "Patient Detail View did not open.")
        
        // Go back to the patient list
        app.navigationBars.buttons.firstMatch.tap()
    }
}
