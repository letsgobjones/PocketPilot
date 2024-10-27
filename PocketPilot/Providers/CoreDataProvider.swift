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
