//
//  PrescribedMedicationView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/18/25.
//

import SwiftUI

struct PrescribeMedicationView: View {
    var patientStore: PatientStore
    @Environment(\.dismiss) var dismiss

    @Binding var patient: Patient

    @State private var name = ""
    @State private var dose = ""
    @State private var route = ""
    @State private var freqInput = ""
    @State private var durationInput = ""
    @State private var errorMessage: String? = nil

    var isSaveDisabled: Bool {
        name.isEmpty || dose.isEmpty || route.isEmpty || Int(freqInput) == nil || Int(durationInput) == nil
    }

    var body: some View {
        NavigationStack {
            Form {
                MedicationInputFields(
                    name: $name,
                    dose: $dose,
                    route: $route,
                    freqInput: $freqInput,
                    durationInput: $durationInput
                )
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("ErrorMessage")
                        .accessibilityLabel("Error Message")
                }
            }
            .navigationTitle("Prescribe Medication")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if validateNewMedicationInputs() {
                            guard let frequency = Int(freqInput),
                                  let duration = Int(durationInput)
                            else {
                                errorMessage = "Frequency, Duration, and Dose must be valid integers."
                                return
                            }

                            let medication = Medication(
                                datePrescribed: Date(),
                                name: name,
                                dose: dose,
                                route: route,
                                frequency: frequency,
                                duration: duration
                            )
                            do {
                                try patient.prescribeMedication(medication)
                                dismiss()
                            } catch DuplicateMedicationError.alreadyPrescribed {
                                errorMessage = "This medication is already prescribed."
                            } catch {
                                errorMessage = "Unexpected error occurred."
                            }
                        }
                    }
                    .disabled(isSaveDisabled) // Ensure save button is disabled for invalid inputs
                    .accessibilityIdentifier("SaveButton")
                    .accessibilityLabel("Save")
                    .accessibilityHint("Saves the prescribed medication")
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("CancelButton")
                    .accessibilityLabel("Cancel")
                    .accessibilityHint("Dismisses the form without saving changes")
                }
            }
        }
    }

    private func validateNewMedicationInputs() -> Bool {
        if Double(freqInput) == nil || Double(freqInput)! <= 0 {
            errorMessage = "Frequency must be a positive number."
            return false
        }
        
        if Double(durationInput) == nil || Double(durationInput)! <= 0 {
            errorMessage = "Duration must be a positive number."
            return false
        }

        errorMessage = nil
        return true
    }
}

#Preview {
    //
}
