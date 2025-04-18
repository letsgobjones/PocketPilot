//
//  PocketPilotApp.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

@main
struct PocketPilotApp: App {
  let tagSeeder: TagsSeeder
  let coreDataProvider = CoreDataProvider.shared
  let budgetStore = BudgetStore()
  init() {
    
    tagSeeder = TagsSeeder(context: CoreDataProvider.shared.context)
    
  }
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView(budgetStore: BudgetStore())
      }
      .environment(\.managedObjectContext, CoreDataProvider.shared.context)
      .task { // If performing asyn, use .task
        
//        await withCheckedContinuation { continuation in
//          coreDataProvider.persistentContainer.loadPersistentStores { description, error in
//            if let error = error {
//              print("Core Data failed to load: \(error.localizedDescription)")
//            }
//            continuation.resume()
//            
//          }
//        }
        
        do {
        try await coreDataProvider.loadPersistentStores()
        let hasSeedData = UserDefaults.standard.bool(forKey: "hasSeedData")
        guard !hasSeedData else { return }
        
        let commonTags: [String] = ["Food", "Dining", "Travel", "Entertainment", "Work", "Health", "Shopping", "Finance", "Transportation", "Personal", "Groceies", "Miscellaneous", "Education"]
        
        
          try  tagSeeder.seed(commonTags)
          UserDefaults.standard.setValue(true, forKey: "hasSeedData")
        } catch {
          print("Error seeding tags: \(error)")
        }
        
      }
      
      //            .environmentObject(BudgetStore())
      //            .environment(\.managedObjectContext, CoreDataProvider().context)
      //          .environment(\.managedObjectContext, CoreDataProvider.shared.context)
      
    }
  }
}


