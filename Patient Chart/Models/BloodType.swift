//
//  BlootType.swift
//  Patient Chart
//
//  Created by Priyanka Shrestha on 1/12/25.
//

import Foundation

enum BloodType: String, CaseIterable, Identifiable {
    case APos = "A+"
    case ANeg = "A-"
    case BPos = "B+"
    case BNeg = "B-"
    case OPos = "O+"
    case ONeg = "O-"
    case ABPos = "AB+"
    case ABNeg = "AB-"

    var id: String { self.rawValue }

    static func possibleDonors(for type: BloodType) -> [BloodType] {
        switch type {
        case .OPos, .ONeg:
            return [.OPos, .ONeg]
        case .APos:
            return [.APos, .ANeg, .OPos, .ONeg]
        case .ANeg:
            return [.ANeg, .ONeg]
        case .BPos:
            return [.BPos, .BNeg, .OPos, .ONeg]
        case .BNeg:
            return [.BNeg, .ONeg]
        case .ABPos:
            return BloodType.allCases
        case .ABNeg:
            return [.ABNeg, .ANeg, .BNeg, .ONeg]
        }
    }
    
    static func compatibleRecipients(for type: BloodType) -> [BloodType] {
        switch type {
        case .OPos:
            return [.OPos, .APos, .BPos, .ABPos]
        case .ONeg:
            return BloodType.allCases
        case .APos:
            return [.APos, .ABPos]
        case .ANeg:
            return [.ANeg, .APos, .ABNeg, .ABPos]
        case .BPos:
            return [.BPos, .ABPos]
        case .BNeg:
            return [.BNeg, .BPos, .ABNeg, .ABPos]
        case .ABPos:
            return [.ABPos]
        case .ABNeg:
            return [.ABNeg, .ABPos]
        }
    }
}
