//
//  PocketPilotApp.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

@main
struct PocketPilotApp: App {
  
  let provider: CoreDataProvider
  
  init() {
    provider = CoreDataProvider()
  }
  
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            ContentView()
              .environment(\.managedObjectContext, provider.context)
              .environmentObject(BudgetStore(context: provider.context))
          }
        }
    }
}
