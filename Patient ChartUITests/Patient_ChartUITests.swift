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
    
    // Helper method to add a new patient with required fields.
    @MainActor
    func makePatient(firstName: String, lastName: String, height: String, weight: String, age: Int) {
        let app = XCUIApplication()
        app.buttons["addPatientButton"].tap()
        
        // Input the first name
        app.textFields["firstNameField"].tap()
        app.textFields["firstNameField"].typeText(firstName)
        
        // Input the last name
        app.textFields["lastNameField"].tap()
        app.textFields["lastNameField"].typeText(lastName)
        
        // Calculate the date of birth based on the age
        let currentYear = Calendar.current.component(.year, from: Date())
        let birthYear = currentYear - age
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Format for full month name
        let birthMonth = dateFormatter.string(from: Date()) // Get the month name
        let birthDay = Calendar.current.component(.day, from: Date())

        // Interact with the DatePicker picker wheels
        app.datePickers["dateOfBirthField"].tap()
        app.staticTexts["\(birthDay)"].tap()
        app.staticTexts["January 2025"].tap()
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "\(birthMonth)")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "\(birthYear)")
        app.buttons["PopoverDismissRegion"].tap()
        
        // Input the height
        app.textFields["heightField"].tap()
        app.textFields["heightField"].typeText(height)
        
        // Input the weight
        app.textFields["weightField"].tap()
        app.textFields["weightField"].typeText(weight)
        
        // Save the patient
        app.buttons["savePatientButton"].tap()
    }
    
    // Helper method to add a medication for a patient.
    @MainActor
    func makeMedication(medicationName: String, medicationDose: String, medicationRoute: String, medicationFrequency: Int, medicationDuration: Int) {
        let app = XCUIApplication()
        app.textFields["MedicationNameField"].tap()
        app.textFields["MedicationNameField"].typeText(medicationName)
        app.textFields["MedicationDoseField"].tap()
        app.textFields["MedicationDoseField"].typeText(medicationDose)
        app.textFields["MedicationRouteField"].tap()
        app.textFields["MedicationRouteField"].typeText(medicationRoute)
        app.textFields["MedicationFrequencyField"].tap()
        app.textFields["MedicationFrequencyField"].typeText(String(medicationFrequency))
        app.textFields["MedicationDurationField"].tap()
        app.textFields["MedicationDurationField"].typeText(String(medicationDuration))
        app.buttons["SaveMedicationButton"].tap()
    }

    // Test the functionality of the Patient List View, including adding and searching for a patient.
    @MainActor
    func testPatientListView() throws {
        let app = XCUIApplication()
        app.launch()
        makePatient(firstName: "Boba", lastName: "Fett", height: "180", weight: "170", age: 0)
        
        // Test the search functionality
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field is missing.")
        
        searchField.tap()
        searchField.typeText("Fett")
        
        let filteredCell = app.cells.staticTexts["patientName_Fett_Boba"]
        XCTAssertTrue(filteredCell.exists, "Search filter is not working correctly for 'Fett'.")

        // Test tapping a patient entry
        filteredCell.tap()
        XCTAssertTrue(app.navigationBars["Patient Details"].exists, "Patient Detail View did not open.")
        
        // Go back to the patient list
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Patients"].exists, "Failed to navigate back to Patient List.")
    }
    
    // Test the form validation for adding a patient with missing required fields.
    @MainActor
    func testAddPatientWithMissingFields() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addPatientButton"].tap()

        // Leave First Name empty
        app.textFields["lastNameField"].tap()
        app.textFields["lastNameField"].typeText("Smith")

        app.textFields["heightField"].tap()
        app.textFields["heightField"].typeText("175")

        app.textFields["weightField"].tap()
        app.textFields["weightField"].typeText("70")

        XCTAssertFalse(app.buttons["savePatientButton"].isEnabled, "Save button should be disabled when required fields are missing.")
    }
    
    // Test that the patient list is correctly sorted alphabetically by last name.
    @MainActor
    func testPatientListSorting() throws {
        let app = XCUIApplication()
        app.launch()

        makePatient(firstName: "Alice", lastName: "Zebra", height: "160", weight: "60", age: 5)
        makePatient(firstName: "Bob", lastName: "Anderson", height: "175", weight: "80", age: 10)

        // Check that the patient list is sorted alphabetically by last name
        let firstCell = app.cells.element(boundBy: 0).staticTexts.firstMatch
        XCTAssertTrue(firstCell.label.contains("Anderson"), "Patients are not sorted alphabetically by last name.")
    }
    
    // Test searching for a patient that does not exist in the patient list.
    @MainActor
    func testSearchForNonExistentPatient() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("NonExistent")

        XCTAssertTrue(app.cells.count == 0, "Search results should be empty for non-existent patient.")
    }
    
    // Test validation and error handling in the Prescribe Medication View.
    @MainActor
    func testPrescribeMedicationValidation() throws {
        let app = XCUIApplication()
        app.launch()

        makePatient(firstName: "Tony", lastName: "Stark", height: "185", weight: "85", age: 45)
        app.cells.staticTexts["patientName_Stark_Tony"].tap()

        app.buttons["prescribeMedicationButton"].tap()

        XCTAssertFalse(app.buttons["SaveMedicationButton"].isEnabled, "Save button should be disabled when required fields are empty.")
        
        
        makeMedication(medicationName: "Aspirin", medicationDose: "100", medicationRoute: "Oral", medicationFrequency: 1, medicationDuration: 7)
   
        XCTAssertTrue(app.cells.staticTexts["medication_Aspirin"].exists, "Medication was not added to the patient details.")
        app.buttons["prescribeMedicationButton"].tap()
        makeMedication(medicationName: "Aspirin", medicationDose: "100", medicationRoute: "Oral", medicationFrequency: 1, medicationDuration: 7)
        
        // Assert the error message is displayed
        let errorMessage = app.staticTexts["ErrorMessage"]
        XCTAssertTrue(errorMessage.exists, "Duplicate medication error message is missing.")
    }
}

