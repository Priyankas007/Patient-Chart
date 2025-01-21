//
//  Patient_ChartUITests.swift
//  Patient ChartUITests
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Testing
import Foundation
@testable import Patient_Chart


struct PatientChartTests {
    @Test("Medication List Filtering and Sorting")
    func testMedicationList() {
        let medication1 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 2, duration: 20)
        let medication2 = Medication(datePrescribed:  Calendar.current.date(byAdding: .day, value: -20, to: Date())!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 30)
        let medication3 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -30, to: Date())!, name: "Losartan", dose: "50 mg", route: "by mouth", frequency: 1, duration: 10)

        let patient = Patient(
                firstName: "John",
                lastName: "Doe",
                dateOfBirth: Calendar.current.date(byAdding: .year, value: -90, to: Date())!,
                height: 180.0,
                weight: 75.0,
                bloodType: .OPos,
                medications: [medication1, medication2, medication3]
        )
        let currentMedications = patient.medicationList()

        #expect(currentMedications.count == 2)

        #expect(currentMedications[0].name == "Metoprolol")

        #expect(currentMedications[1].name == "Aspirin")
    }

    @Test("Prescribing a New Medication")
    func testPrescribeMedication() throws {
        let medication1 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 2, duration: 20)
        let medication2 = Medication(datePrescribed:  Calendar.current.date(byAdding: .day, value: -20, to: Date())!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 30)
        let medication3 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -30, to: Date())!, name: "Losartan", dose: "50 mg", route: "by mouth", frequency: 1, duration: 10)

        var  patient = Patient(
                firstName: "John",
                lastName: "Doe",
                dateOfBirth: Calendar.current.date(byAdding: .year, value: -90, to: Date())!,
                height: 180.0,
                weight: 75.0,
                bloodType: .OPos,
                medications: [medication1, medication2, medication3]
        )
        
        let newMedication = Medication(
            datePrescribed: Date(),
            name: "Vancomycin",
            dose: "20 mg/kg",
            route: "intravenous (IV)",
            frequency: 2,
            duration: 14
        )
        try patient.prescribeMedication(newMedication)

        #expect(patient.medications.contains { $0.name == "Vancomycin" })
    }

    @Test("Duplicate Medication Error Handling")
    func testDuplicateMedicationThrowsError() throws {
        let medication1 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, name: "Aspirin", dose: "81 mg", route: "by mouth", frequency: 2, duration: 20)
        let medication2 = Medication(datePrescribed:  Calendar.current.date(byAdding: .day, value: -20, to: Date())!, name: "Metoprolol", dose: "25 mg", route: "by mouth", frequency: 1, duration: 30)
        let medication3 = Medication(datePrescribed: Calendar.current.date(byAdding: .day, value: -30, to: Date())!, name: "Losartan", dose: "50 mg", route: "by mouth", frequency: 1, duration: 10)
        
        var  patient = Patient(
                firstName: "John",
                lastName: "Doe",
                dateOfBirth: Calendar.current.date(byAdding: .year, value: -90, to: Date())!,
                height: 180.0,
                weight: 75.0,
                bloodType: .OPos,
                medications: [medication1, medication2, medication3]
        )
        
        let duplicateMedication = Medication(
            datePrescribed: Date(),
            name: "Aspirin",
            dose: "81 mg",
            route: "by mouth",
            frequency: 2,
            duration: 5
        )

        #expect(throws: DuplicateMedicationError.alreadyPrescribed) {
            try patient.prescribeMedication(duplicateMedication)
        }
    }
}

