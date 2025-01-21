//
//  MedicationListView.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/20/25.
//

import SwiftUI

// Medications List Section
struct MedicationListView: View {
    @Binding var medications: [Medication] // Editable array
    
    var body: some View {
        Section(header: Text("Medications")) {
            ForEach($medications.indices, id: \.self) { index in
                MedicationRow(medication: $medications[index])
            }
        }
    }
}
#Preview {
    //MedicationListView()
}
