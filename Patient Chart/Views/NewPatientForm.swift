//
//  newPatientForm.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/18/25.
//

import SwiftUI

struct NewPatientForm: View {
    var patientStore: PatientStore
    @Environment(\.dismiss) private var dismiss
    @State private var errorMessage: String? = nil

    // State variables for user input
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType? = nil

    /// Computed property to determine if the Save button should be disabled
    var isSaveDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty || height.isEmpty || weight.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                // Required Fields Section
                RequiredFieldsView(
                    firstName: $firstName,
                    lastName: $lastName,
                    dateOfBirth: $dateOfBirth,
                    height: $height,
                    weight: $weight
                )

                // Optional Fields Section
                OptionalFieldsView(bloodType: $bloodType)

                // Inline Error Message
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .accessibilityLabel("Error: \(errorMessage)")
                            .accessibilityIdentifier("ErrorMessage")
                    }
                }
            }
            .navigationTitle("Add New Patient")
            .toolbar {
                // Save Button
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if validateNewPatientInputs() {
                            let newPatient = Patient(
                                firstName: firstName,
                                lastName: lastName,
                                dateOfBirth: dateOfBirth,
                                height: Double(height) ?? 0,
                                weight: Double(weight) ?? 0,
                                bloodType: bloodType,
                                medications: []
                            )
                            patientStore.addPatient(newPatient)
                            dismiss()
                        }
                    }
                    .disabled(isSaveDisabled)
                    .accessibilityLabel("Save patient button")
                    .accessibilityIdentifier("savePatientButton")
                }

                // Cancel Button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityLabel("Cancel button")
                    .accessibilityIdentifier("cancelPatientButton")
                }
            }
        }
    }

    /// Validates the inputs for creating a new patient.
    private func validateNewPatientInputs() -> Bool {
        if Double(height) == nil || Double(height)! <= 0 {
            errorMessage = "Height must be a positive number."
            return false
        }

        if Double(weight) == nil || Double(weight)! <= 0 {
            errorMessage = "Weight must be a positive number."
            return false
        }

        errorMessage = nil
        return true
    }
}

#Preview {
    let samplePatientStore = PatientStore()
    NewPatientForm(patientStore: samplePatientStore)
}
