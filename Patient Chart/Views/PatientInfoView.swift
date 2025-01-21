//
//  PatientInfoView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Patient Information Section
struct PatientInfoView: View {
    let patient: Patient
    
    var body: some View {
        Section(header: Text("Information")) {
            VStack(alignment: .leading, spacing: 10) {
                InfoRow(label: "Age", value: "\(patient.calculateAge())", unit: "")
                InfoRow(label: "Height", value: String(format: "%.1f", patient.height), unit: "cm")
                InfoRow(label: "Weight", value: String(format: "%.1f", patient.weight), unit: "kg")
                
                if let bloodType = patient.bloodType {
                    InfoRow(label: "Blood Type", value: bloodType.rawValue)
                }
                
                InfoRow(label: "MRN", value: patient.medicalRecordNumber.uuidString)
                    .font(.system(size: 11))
            }
        }
    }
}

#Preview {
    PatientInfoView(patient: {
        let samplePatientStore = PatientStore()
        samplePatientStore.addPatient(Patient(firstName: "John", lastName: "Doe", dateOfBirth: Date(), height: 180, weight: 75, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Jane", lastName: "Smith", dateOfBirth: Date(), height: 165, weight: 65, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Jane", lastName: "Apple", dateOfBirth: Date(), height: 165, weight: 65, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Jane", lastName: "Applezen", dateOfBirth: Date(), height: 165, weight: 65, medications: []))
        return samplePatientStore.patients[0]
    }())
}
