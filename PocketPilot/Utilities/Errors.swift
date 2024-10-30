//
//  Errors.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//



import Foundation

enum BudgetError: Error, LocalizedError {
    case budgetAlreadyExists
  case unableToSave
    case unknown

    var errorDescription: String? {
        switch self {
        case .budgetAlreadyExists:
            return "A budget with that name already exists."
        case .unknown:
            return "An unknown error occurred."
        case .unableToSave:
          return "Unable to save the budget."
        }
    }
}
