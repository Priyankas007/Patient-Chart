//
//  OptionalFieldsView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/22/25.
//

import SwiftUI

struct OptionalFieldsView: View {
    @Binding var bloodType: BloodType?

    var body: some View {
        Section(header: Text("Optional")) {
            Picker("Blood Type", selection: $bloodType) {
                Text("None").tag(BloodType?.none) // Handle nil case
                ForEach(BloodType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type as BloodType?)
                }
            }
            .accessibilityLabel("Blood Type picker")
        }
    }
}
