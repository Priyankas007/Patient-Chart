//
//  PrescribeMedicationButton.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Prescribe Medication Button
struct PrescribeMedicationButton: View {
    @Binding var isShowingPrescribeMedicationView: Bool
    
    var body: some View {
        Section {
            Button(action: {
                isShowingPrescribeMedicationView = true
            }) {
                HStack {
                    Spacer()
                    Text("Prescribe Medication")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            .accessibilityLabel("Prescribe a new medication for this patient")
        }
    }
}
#Preview {
    //PrescribeMedicationButton()
}
