//
//  CoreDataProvider.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import Foundation
import CoreData


class CoreDataProvider {
  
  let persistentContainer: NSPersistentContainer
  
  
  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }
  
  
  static var preview : CoreDataProvider = {
    let provider = CoreDataProvider(inMemory: true)
    let context = provider.context
    
    let entertainment = Budget(context: context)
    entertainment.title = "Entertainment"
    entertainment.limit = 500
    entertainment.dateCreated = Date()
    
    let groceries = Budget(context: context)
    groceries.title = "Groceries"
    groceries.limit = 1000
    groceries.dateCreated = Date()
    
    let milk = Expense(context: context)
    milk.title = "Milk"
    milk.amount = 5.50
    milk.dateCreated = Date()
    
    let cookie = Expense(context: context)
    cookie.title = "Cookie"
    cookie.amount = 2.50
    cookie.dateCreated = Date()
    
    groceries.addToExpenses(milk)
    groceries.addToExpenses(cookie)

    
    //inset tags
    
    let commonTags: [String] = ["Food", "Travel", "Entertainment", "Work", "Health", "Shopping","Transportation", "Personal"]
    
    for commonTag in commonTags {
      let tag = Tag(context: context)
      tag.name = commonTag
    }
    
    do {
      try context.save()
    } catch {
      print(error)
    }
    return provider
    
  }()
  
  init(inMemory: Bool = false) {
    persistentContainer = NSPersistentContainer(name: "PocketPilotModel")
    
    if inMemory {
      persistentContainer.persistentStoreDescriptions.first?.url = URL(filePath: "dev/null")
    }
    persistentContainer.loadPersistentStores { _, error in
      if let error {
        fatalError("Core Data store failed to initialize: \(error)")
      }
    }
    
  }
  
}
