//
//  PatientViewStore.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/16/25.
//

import SwiftUI
import Observation

@Observable class PatientStore: Identifiable {
    var patients: [Patient] = []

    func addPatient(_ patient: Patient) {
        patients.append(patient)
        patients.sort { $0.lastName < $1.lastName }
    }
    
    func removePatient(by id: UUID) {
        patients.removeAll { $0.id == id }
    }
    
    func findPatient(by id: UUID) -> Patient? {
        return patients.first { $0.id == id }
    }
    
    func filterPatients(by lastName: String) -> [Patient] {
        return patients.filter { $0.lastName.lowercased().contains(lastName.lowercased()) }
    }
    
    init(patients: [Patient] = []) {
        self.patients = patients.sorted { $0.lastName < $1.lastName }
    }
}

