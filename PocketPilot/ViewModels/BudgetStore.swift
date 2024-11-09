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
  
  //CRUD
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
  
  

  
  //Filter
  func filterByTitle(title: String, context: NSManagedObjectContext) -> [Expense] {
    let request = Expense.fetchRequest()
    request.predicate = NSPredicate(format: "title BEGINSWITH %@", title)

    return performFetch(request: request, context: context)
  }
  
  
  func filterByDate(startDate: Date, endDate: Date, context: NSManagedObjectContext) -> [Expense] {
    let request = Expense.fetchRequest()
    request.predicate = NSPredicate(format: "dateCreated >= %@ && dateCreated <= %@", startDate as NSDate, endDate as NSDate)
  
    return performFetch(request: request, context: context)
  }
  
  
  
  func filterTags(selectedTags: Set<Tag>, context: NSManagedObjectContext) -> [Expense] {
    guard !selectedTags.isEmpty else {
      let request = Expense.fetchRequest()
      
      return performFetch(request: request, context: context)
    }
    
    let selectedTagNames = selectedTags.map { $0.name }
    let request = Expense.fetchRequest()
    request.predicate = NSPredicate(format: "ANY tags.name IN %@", selectedTagNames)
    
    return performFetch(request: request, context: context)
  }
  
  
  func filterByPrice(startPrice: Double?, endPrice: Double?, context: NSManagedObjectContext) -> [Expense] {
    guard let startPrice,
          let endPrice else { return [] }
    
    let request = Expense.fetchRequest()
    request.predicate = NSPredicate(format: "amount >= %@ && amount <= %@", NSNumber(value: startPrice), NSNumber(value: endPrice))
    
    return performFetch(request: request, context: context)
  }
  
  
  //Sort
  
  func performSort(selectedSortOptions: SortingOptions?, selectedSortDirection: SortingDirection?, context: NSManagedObjectContext)-> [Expense]  {
    guard let sortOption = selectedSortOptions else { return [] }
    
    let request = Expense.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: sortOption.key, ascending: selectedSortDirection == .ascending ? true : false)]
    
    return performFetch(request: request, context: context)
  }
  
  
  
  //Utilities
  private func saveContext(_ context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      print("Error saving context:", error)
    }
  }
  
  func performFetch(request: NSFetchRequest<Expense>, context: NSManagedObjectContext) -> [Expense] {
      do {
          return try context.fetch(request)
      } catch {
          print(error)
          return []
      }
  }
}

