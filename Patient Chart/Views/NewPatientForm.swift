//
//  newPatientForm.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/18/25.
//

import SwiftUI

struct NewPatientForm: View {
    var patientStore: PatientStore
    //@Environment(PatientStore.self) private var patientObject
    @Environment(\.dismiss) private var dismiss
    @State private var errorMessage: String? = nil

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: BloodType? = nil

    var isSaveDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty || height.isEmpty || weight.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Required")) {
                    TextField("First Name", text: $firstName)
                        .accessibilityLabel("First Name input field")
                        .accessibilityIdentifier("firstNameField")
                    TextField("Last Name", text: $lastName)
                        .accessibilityLabel("Last Name input field")
                        .accessibilityIdentifier("lastNamefield")
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .accessibilityLabel("Date of Birth picker")
                    TextField("Height (cm)", text: $height)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Height input field")
                        .accessibilityIdentifier("heightField")
                    TextField("Weight (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Weight input field")
                        .accessibilityIdentifier("weightField")
                    
                }

                Section(header: Text("Optional")) {
                    Picker("Blood Type", selection: $bloodType) {
                        Text("None").tag(BloodType?.none) // Handle nil case
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type as BloodType?)
                        }
                    }
                    .accessibilityLabel("Blood Type picker")
                }
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage).foregroundColor(.red)
                            .accessibilityLabel("Error: \(errorMessage)")
                    }
                }
            }
            .navigationTitle("Add New Patient")
            .toolbar {
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
                                medications: [])
                            patientStore.addPatient(newPatient)
                            dismiss()
                        }
                    }
                    .disabled(isSaveDisabled)
                    .accessibilityLabel("Save button")
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityLabel("Cancel button")
                }
            }
        }
    }

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
