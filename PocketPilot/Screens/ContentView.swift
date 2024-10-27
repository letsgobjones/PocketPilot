//
//  ContentView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var budgetStore: BudgetStore

  @State private var isPresented: Bool = false
    var body: some View {
      VStack {
        BudgetListView()
      }.navigationTitle("Pocket Pilot 🧑🏾‍✈️")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button("Add Budget") {
              isPresented = true
              budgetStore.errorMessage = nil
            }
          }
        }.sheet(isPresented: $isPresented, content: {
          AddBudgetScreen()
        })
    }
  }

#Preview {
  NavigationStack {
    ContentView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore(content: CoreDataProvider.preview.context))
  }
}
