//
//  BudgetStore.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import Foundation
import CoreData

class BudgetStore: ObservableObject {
  private var viewContext: NSManagedObjectContext
  
  @Published var errorMessage: BudgetError? = nil
  @Published var selectedCurrency : String = "USD"
  
  init (content: NSManagedObjectContext) {
    self.viewContext = content
  }
  
  
  func exists(context: NSManagedObjectContext, title: String) -> Bool {
    let request = Budget.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", title)
    
    do {
     let results = try context.fetch(request)
      return !results.isEmpty
    } catch {
      return false
    }
  }
  
  
  func saveBudget(title: String, limit: Double?)  {
    let budget = Budget(context: viewContext)
    budget.title = title
    budget.limit = limit ?? 0.0
    budget.dateCreated = Date()
    do {
      try viewContext.save()
      errorMessage = nil
    } catch {
      errorMessage = .unableToSave
    }
  }
}
