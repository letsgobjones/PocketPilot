//
//  Enums.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//



import Foundation

enum BudgetError: Error, LocalizedError {
    case budgetAlreadyExists
  case expenseAlreadyExists
  case unableToSave
    case unknown

    var errorDescription: String? {
        switch self {
        case .budgetAlreadyExists:
            return "A budget with that name already exists."
        case .expenseAlreadyExists:
            return "A expense with that name already exists."
        case .unknown:
            return "An unknown error occurred."
        case .unableToSave:
          return "Unable to save the budget."
        }
    }
}

enum SortingOptions: String, CaseIterable, Identifiable {
  case title = "title"
  case date = "dateCreated"
  
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
    rawValue
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


enum FilterOptions: Identifiable, Equatable {
case none
  case byTags(Set<Tag>)
  case byPriceRange(minPrice: Double, maxPrice: Double)
  case byTitle(String)
  case byDate(startDate: Date, endDate: Date)
  
  
  var id: String {
    switch self {
    case .none:
      return "none"
    case .byTags:
      return "tags"
    case .byPriceRange:
      return "princeRane"
    case .byTitle:
      return "title"
    case .byDate:
      return "date"
    }
  }
  
}
