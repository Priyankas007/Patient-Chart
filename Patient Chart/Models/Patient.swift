//
//  Patient.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Foundation

struct Patient : Identifiable {
    let medicalRecordNumber: UUID // Acts as the unique identifier
    var id: UUID { medicalRecordNumber } // Conforms to `Identifiable`
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var height: Double // in cm
    var weight: Double // in lbs
    var bloodType: BloodType? // ? indicates optional
    var medications: [Medication]
    
    // Initializer
    init(firstName: String, lastName: String, dateOfBirth: Date, height: Double, weight: Double, bloodType: BloodType? = nil, medications: [Medication]) {
        self.medicalRecordNumber = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    // Returns a patients last name, first name, and age
    func fullNameAndAge() -> String {
        "\(lastName), \(firstName) (\(calculateAge()) years)"
    }
    
    // Returns a patient's age
    func calculateAge() -> String {
        let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date())
        let age = ageComponents.year ?? -1
        return "\(age)"
    }
    
    // Returns a list of current medications (not expired) for the patient in order of when they were first prescribed
    func medicationList() -> [Medication] {
        return medications.filter { !$0.isCompleted}.sorted(by: { $0.datePrescribed < $1.datePrescribed})
    }
    
    // Adds another medication to the Patient's list of prescribed medications
    mutating func prescribeMedication(_ medication: Medication) throws {
        guard !medicationList().contains(where: { $0.name == medication.name && $0.dose == medication.dose && $0.route == medication.route }) else {
            throw DuplicateMedicationError.alreadyPrescribed
        }
        medications.append(medication)
    }
    
    // Returns compatible bloodtypes for a given patient
    func compatibleBloodTypes() -> [BloodType] {
        guard let type = bloodType else { return [] }
        return BloodType.possibleDonors(for: type)
    }
    
    // BONUS FUNCTIONS
    mutating func removeCompletedMedications() {
        medications.removeAll { $0.isCompleted }
    }
    
    func nextPrescriptionDate() -> Date? {
        let activeMedications = medications.filter { !$0.isCompleted }
        let dates = activeMedications.compactMap { medication in
            Calendar.current.date(byAdding: .day, value: medication.duration, to: medication.datePrescribed)
        }
        return dates.min()
    }
}
