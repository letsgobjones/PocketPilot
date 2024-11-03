//
//  BudgetListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct BudgetListView: View {
  @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
  @EnvironmentObject var budgetStore: BudgetStore
  @Environment(\.managedObjectContext) private var viewContext
  
  var body: some View {
    if budgets.isEmpty {
      Spacer()
      Text("Please create a budget to get started.")
      Spacer()
    } else {
      List {
        ForEach (budgets) { budget in
          NavigationLink {
            BudgetDetailScreen(budget: budget)
          } label: {
            BudgetCellView(budget: budget)
          }
        }.onDelete { indexSet in
          budgetStore.deleteBudget( indexSet, budgets: Array(budgets), context: viewContext)
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    BudgetListView()
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)

}


