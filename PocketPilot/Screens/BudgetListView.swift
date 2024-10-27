//
//  BudgetListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct BudgetListView: View {
  
  @FetchRequest(sortDescriptors: [])  private var budgets: FetchedResults<Budget>
  @State private var isPresented: Bool = false
  
  var body: some View {
    VStack {
      Text("Budgets will be displayed here...")
    }.navigationTitle("Pocket Pilot 🧑🏾‍✈️")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add Budget") {
            isPresented = true
          }
        }
      }.sheet(isPresented: $isPresented, content: {
        AddBudgetScreen()
      })
  }
}

#Preview {
  NavigationStack {
    BudgetListView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  }
}
