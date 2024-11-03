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
      
      init() {

        tagSeeder = TagsSeeder(context: CoreDataProvider().context)
      }
  var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .task { // If performing asyn, use .task
              let hasSeedData = UserDefaults.standard.bool(forKey: "hasSeedData")
              guard !hasSeedData else { return }
              
              let commonTags: [String] = ["Food", "Dining", "Travel", "Entertainment", "Work", "Health", "Shopping", "Finance", "Transportation", "Personal", "Groceies", "Miscellaneous", "Education"]
                
                do {
                  try  tagSeeder.seed(commonTags)
                  UserDefaults.standard.setValue(true, forKey: "hasSeedData")
                } catch {
                  print("Error seeding tags: \(error)")
                }
              }
            
            .environmentObject(BudgetStore())
            .environment(\.managedObjectContext, CoreDataProvider().context)
        }
    }
}
