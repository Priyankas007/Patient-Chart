//
//  MedicationInputFields.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

struct MedicationInputFields: View {
    @Binding var name: String
    @Binding var dose: String
    @Binding var route: String
    @Binding var freqInput: String
    @Binding var durationInput: String

    var body: some View {
        Group {
            TextField("Name", text: $name)
                .accessibilityIdentifier("MedicationNameField")
                .accessibilityLabel("Medication Name")
                .accessibilityHint("Enter the name of the medication")
            
            TextField("Dose (mg)", text: $dose)
                .accessibilityIdentifier("MedicationDoseField")
                .accessibilityLabel("Medication Dose")
                .accessibilityHint("Enter the dose of the medication in milligrams")
                .keyboardType(.numberPad)

            TextField("Route (e.g. Oral)", text: $route)
                .accessibilityIdentifier("MedicationRouteField")
                .accessibilityLabel("Medication Route")
                .accessibilityHint("Enter the route of administration, e.g., Oral or IV")

            TextField("Frequency (per day)", text: $freqInput)
                .accessibilityIdentifier("MedicationFrequencyField")
                .accessibilityLabel("Medication Frequency")
                .accessibilityHint("Enter the frequency of the medication, e.g., 2 times a day")
                .keyboardType(.numberPad)

            TextField("Duration (in days)", text: $durationInput)
                .accessibilityIdentifier("MedicationDurationField")
                .accessibilityLabel("Medication Duration")
                .accessibilityHint("Enter the duration of the medication in days")
                .keyboardType(.numberPad)
        }
    }
}

#Preview {
    //MedicationInputFields()
}
