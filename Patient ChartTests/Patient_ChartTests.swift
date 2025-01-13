//
//  Patient_ChartTests.swift
//  Patient ChartTests
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import XCTest
@testable import Patient_Chart

final class Patient_ChartTests: XCTestCase {
    
    var patient: Patient!
    var medication1: Medication!
    var medication2: Medication!
    var medication3: Medication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let datePrescribed1 = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        let datePrescribed2 = Calendar.current.date(byAdding: .day, value: -20, to: Date())!
        let datePrescribed3 = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        
        medication1 = Medication(datePrescribed: datePrescribed1, name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 2, duration: 20)
        medication2 = Medication(datePrescribed: datePrescribed2, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 30)
        medication3 = Medication(datePrescribed: datePrescribed3, name: "Losartan", dose: "50 mg", route: "by mouth", frequency: 1, duration: 10)
        
        patient = Patient(
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -90, to: Date())!,
            height: 180.0,
            weight: 75.0,
            bloodType: .OPos,
            medications: [medication1, medication2, medication3]
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        patient = nil
        medication1 = nil
        medication2 = nil
        medication3 = nil
    }
    
    func testMedicationList() throws {
        let currentMedications = patient.medicationList()

        // Assert the number of active medications
        XCTAssertEqual(currentMedications.count, 2, "The number of active medications is wrong.")

        // Assert the medications are sorted by date prescribed (descending)
        XCTAssertEqual(currentMedications[0].name, "Metoprolol", "The oldest prescribed medication should be first.")
        XCTAssertEqual(currentMedications[1].name, "Aspirin","The most recently prescribed medication should be last.")
    }
    
    func testPrescribeMedication() throws {
        // Test that prescribing a new medication works correctly
        let newMedication = Medication(
            datePrescribed: Date(),
            name: "Vancomycin",
            dose: "20 mg/kg",
            route: "intravenous (IV)",
            frequency: 2,
            duration: 14
        )
        try patient.prescribeMedication(newMedication)

        XCTAssertTrue(patient.medications.contains(where: { $0.name == "Vancomycin" }), "The new medication was not added to the patient's medication list.")
    }
    
    func testDuplicateMedicationThrowsError() throws {
        // Test that prescribing a duplicate medication throws an error
        let duplicateMedication = Medication(
            datePrescribed: Date(),
            name: "Aspirin",
            dose: "81 mg",
            route: "by mouth",
            frequency: 2,
            duration: 5
        )

        XCTAssertThrowsError(try patient.prescribeMedication(duplicateMedication)) { error in
            XCTAssertEqual(error as? DuplicateMedicationError, .alreadyPrescribed, "The error thrown was not a DuplicateMedicationError.")
        }
    }
    
    func testBloodTypeMatch() throws {
        // test that the bloodtype recommended for a person is suitable
        let bloodTypeMatches = patient.compatibleBloodTypes()
        XCTAssertEqual(bloodTypeMatches, [.OPos, .ONeg], "The bloodtype matching is wrong.")
    }

    func testPrintsPatientIntoCorrectly() throws {
        let new_patient = Patient(
            firstName: "Jane",
            lastName: "Doe",
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -20, to: Date())!,
            height: 180.0,
            weight: 75.0,
            bloodType: .ONeg,
            medications: [medication3]
        )
        XCTAssertEqual(new_patient.fullNameAndAge(), "Doe, Jane (20 years)")
    }
    
    // BONUS FUNCTION TEST CASES
    func testRemoveCompletedMedications() throws {
        // Ensure the patient starts with 3 medications
        XCTAssertEqual(patient.medications.count, 3, "Initial medication count should be 3.")
        
        // Remove completed medications
        patient.removeCompletedMedications()
        
        // Validate that only active medications remain
        XCTAssertEqual(patient.medications.count, 2, "After removing completed medications, there should be 2 active medications.")
        XCTAssertFalse(patient.medications.contains(where: { $0.isCompleted }), "No completed medications should remain.")
    }
    
    func testNextPrescriptionDate() throws {
        // Calculate the next prescription date
        let nextDate = patient.nextPrescriptionDate()
        
        // The next prescription date should match the end date of the earliest active medication
        let expectedDate = Calendar.current.date(byAdding: .day, value: medication1.duration, to: medication1.datePrescribed)
        XCTAssertEqual(nextDate, expectedDate, "The next prescription date is incorrect.")
    }

}
