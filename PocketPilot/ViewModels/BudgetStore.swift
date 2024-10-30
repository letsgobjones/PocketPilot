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
  
  init (context: NSManagedObjectContext) {
    self.viewContext = context
  }
  
  
  func budgetExists(context: NSManagedObjectContext, title: String) -> Bool {
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
    
    saveContext()
  }
  
  func addExpense(to budget: Budget, title: String, amount: Double?) {
    let expense = Expense(context: viewContext)
    expense.title = title
    expense.amount = amount ?? 0.0
    expense.dateCreated = Date()
    
    budget.addToExpenses(expense)
    saveContext()
  }
  
  
  private func saveContext()  {
    do {
      try viewContext.save()
      errorMessage = nil
    } catch {
     errorMessage = .unableToSave
    }
  }
}
