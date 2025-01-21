//
//  SwiftUIView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/16/25.
//

import SwiftUI

struct PatientListView: View {
    @State private var patientStore: PatientStore
    @State private var queryText = ""
    @State private var showingNewPatientForm = false
    
    // Initialize with a PatientStore
    init(patientStore: PatientStore = PatientStore()) {
        _patientStore = State(initialValue: patientStore)
    }
    
    var filteredPatients: [Patient] {
        if queryText.isEmpty {
            return patientStore.patients
        } else {
            return patientStore.filterPatients(by: queryText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(queryText.isEmpty ? patientStore.patients : patientStore.filterPatients(by: queryText)) { patient in
                    if let index = patientStore.patients.firstIndex(where: { $0.id == patient.id }) {
                        NavigationLink(destination: PatientDetailView(patient: $patientStore.patients[index])) {
                            PatientRowView(patient: patient)
                        }
                        .accessibilityHint("Tap to view details of \(patient.fullNameAndAge()).")
                    }
                }
            }
            .navigationTitle("Patients")
            .accessibilityIdentifier("PatientsNavigationBar")
            .searchable(text: $queryText)
            .accessibilityIdentifier("searchBar")
            .toolbar {
                // Button to add new patient
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewPatientForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addPatientButton")
                }
            }
        }.sheet(isPresented: $showingNewPatientForm) {
            NewPatientForm(patientStore: patientStore)
        }
    }
}

#Preview {
    PatientListView(patientStore: {
        let samplePatientStore = PatientStore()
        samplePatientStore.addPatient(Patient(firstName: "Anakin", lastName: "Skywalker", dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!, height: 180, weight: 75, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Darth", lastName: "Vader", dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!, height: 165, weight: 65, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Kylo", lastName: "Ren", dateOfBirth: Calendar.current.date(byAdding: .year, value: -23, to: Date())!, height: 165, weight: 65, medications: []))
        samplePatientStore.addPatient(Patient(firstName: "Ray", lastName: "Skywalker", dateOfBirth: Calendar.current.date(byAdding: .year, value: -20, to: Date())!, height: 165, weight: 65, medications: []))
        return samplePatientStore
    }())
}
