//
//  Enums.swift
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

enum SortingOptions: CaseIterable, Identifiable {
  case title
  case date
  
  var id: SortingOptions {
    return self
  }
  
  var title: String {
    switch self {
    case .title:
      return "Title"
    case .date:
      return "Date"
    }
  }
  
  var key: String {
    switch self {
    case .title:
      return "title"
    case .date:
      return "dateCreated"
    }
  }
}

enum SortingDirection: CaseIterable, Identifiable {
  case ascending
  case descending
  
  var id: SortingDirection {
    return self
  }
  
  var title: String {
    switch self {
    case .ascending:
      return "Ascending"
    case .descending:
      return "Descending"
    }
  }
}
