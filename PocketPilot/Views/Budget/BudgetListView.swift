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
  
  private var total: Double {
    budgets.reduce(0) { limit,  budget in
      budget.limit + limit
    }
  }
  
  var body: some View {
    if budgets.isEmpty {
      Spacer()
      Text("Please create a budget to get started.")
      Spacer()
    } else {
      List {
        HStack {
          Spacer()
          Text("Total Limit")
          Text(total, format: .currency(code: budgetStore.selectedCurrency))
          Spacer()
        }.font(.headline)
        
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


