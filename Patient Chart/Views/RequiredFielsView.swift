//
//  RequiredFielsView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/22/25.
//

import SwiftUI

// Subview for required fields in the New Patient Form
struct RequiredFieldsView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var dateOfBirth: Date
    @Binding var height: String
    @Binding var weight: String

    var body: some View {
        Section(header: Text("Required")) {
            TextField("First Name", text: $firstName)
                .accessibilityLabel("First Name input field")
                .accessibilityIdentifier("firstNameField")

            TextField("Last Name", text: $lastName)
                .accessibilityLabel("Last Name input field")
                .accessibilityIdentifier("lastNameField")

            DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                .accessibilityLabel("Date of Birth picker")
                .accessibilityIdentifier("dateOfBirthField")

            TextField("Height (cm)", text: $height)
                .keyboardType(.decimalPad)
                .accessibilityLabel("Height input field")
                .accessibilityIdentifier("heightField")

            TextField("Weight (kg)", text: $weight)
                .keyboardType(.decimalPad)
                .accessibilityLabel("Weight input field")
                .accessibilityIdentifier("weightField")
        }
    }
}
