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
  
  func addExpense(budget: Budget, title: String, amount: Double?, context: NSManagedObjectContext, tags: Set<Tag>) {
    let expense = Expense(context: context)
    expense.title = title
    expense.amount = amount ?? 0.0
    expense.dateCreated = Date()
    
    expense.addToTags(NSSet(set: tags))
    
    budget.addToExpenses(expense)
    saveContext(context)
  }
  
  func deleteExpense(_ indexSet: IndexSet, expenses: [Expense], context: NSManagedObjectContext) {
    indexSet.forEach { index in
      let expense = expenses[index]
      context.delete(expense)
      
      saveContext(context)
    }
  }
  
  func deleteBudget(_ indexSet: IndexSet, budgets: [Budget], context: NSManagedObjectContext) {
    indexSet.forEach { index in
      let budget = budgets[index]
      context.delete(budget)
      
      saveContext(context)
    }
  }
  

  func filterTags(selectedTags: Set<Tag>, context: NSManagedObjectContext) -> [Expense] {
      let selectedTagNames = selectedTags.map { $0.name }
      let request = Expense.fetchRequest()
      request.predicate = NSPredicate(format: "ANY tags.name IN %@", selectedTagNames)
      do {
          return try context.fetch(request)
      } catch {
          print(error)
          return []
      }
  }
  
  
  
  private func saveContext(_ context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      print("Error saving context:", error)
    }
  } 
}

