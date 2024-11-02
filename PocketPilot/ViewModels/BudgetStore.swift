//
//  BudgetStore.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI
import CoreData

class BudgetStore: ObservableObject {
  @Environment(\.managedObjectContext) private var viewContext
  @Published var errorMessage: BudgetError? = nil
  @Published var selectedCurrency : String = "USD"
  
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
  
  func saveBudget(title: String, limit: Double?, context: NSManagedObjectContext )  {
    let budget = Budget(context: context)
    budget.title = title
    budget.limit = limit ?? 0.0
    budget.dateCreated = Date()
    
    saveContext(context)
  }
  
  func addExpense(budget: Budget, title: String, amount: Double?, context: NSManagedObjectContext) {
    let expense = Expense(context: context)
    expense.title = title
    expense.amount = amount ?? 0.0
    expense.dateCreated = Date()
    
    budget.addToExpenses(expense)
    saveContext(context)
  }
  
  private func saveContext(_ context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      print("Error saving context:", error)
    }
  } 
}

