//
//  Errors.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Foundation

enum DuplicateMedicationError: Error, Equatable {
    case alreadyPrescribed
    case obvious(String)
}
