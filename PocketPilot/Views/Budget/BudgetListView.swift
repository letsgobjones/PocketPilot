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
  
  private var totalBudget: Double {
    budgets.reduce(0) { limit,  budget in
      budget.limit + limit
    }
  }
  
  var body: some View {
    if budgets.isEmpty {
      ContentUnavailableView("Please create a budget to get started.", systemImage:  "list.clipboard")
    } else {
      List {
        HStack {
          Spacer()
          Text("Total Limit")
          Text(totalBudget, format: .currency(code: budgetStore.selectedCurrency))
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


