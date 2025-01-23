//
//  PatientDetailView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/16/25.
//

import SwiftUI

struct PatientDetailView: View {
    @Binding var patient: Patient
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingPrescribeMedicationView = false // State variable for sheet
    
    var body: some View {
        NavigationStack {
            VStack {
                PatientHeaderView(patient: patient)
                
                List {
                    PatientInfoView(patient: patient)
                    MedicationListView(medications: $patient.medications)
                }
                
                PrescribeMedicationButton(isShowingPrescribeMedicationView: $isShowingPrescribeMedicationView)
            }
            .navigationTitle("Patient Details")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingPrescribeMedicationView) {
                PrescribeMedicationView(
                    patientStore: PatientStore(), // Pass the appropriate PatientStore
                    patient: $patient // Pass binding for the patient
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var samplePatient = Patient(
        firstName: "John",
        lastName: "Doe",
        dateOfBirth: Calendar.current.date(byAdding: .year, value: -90, to: Date())!,
        height: 180.0,
        weight: 75.0,
        bloodType: .OPos,
        medications: []
    )
    PatientDetailView(patient: $samplePatient)
}
