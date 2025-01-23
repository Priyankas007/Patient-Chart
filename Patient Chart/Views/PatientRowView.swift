//
//  PatientRowView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Extracted row view for better organization
struct PatientRowView: View {
    let patient: Patient
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(patient.fullNameAndAge())
                .font(.headline)
                .accessibilityLabel("\(patient.fullNameAndAge()), medical record number: \(patient.id.uuidString)")
                .accessibilityIdentifier("patientName_\(patient.lastName)_\(patient.firstName)")
            Text("MRN: \(patient.medicalRecordNumber.uuidString)")
                .font(.subheadline)
                .accessibilityHidden(true)
        }
    }
}
#Preview {
    //PatientRowView()
}
