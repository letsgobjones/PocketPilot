//
//  BudgetListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI
import CoreData

struct BudgetListView: View {
  // CHANGE: Add proper fetch request configurations
  @FetchRequest(
    entity: Budget.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Budget.dateCreated, ascending: false)]
  ) private var budgets: FetchedResults<Budget>
  
  @FetchRequest(
    entity: Expense.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Expense.dateCreated, ascending: false)]
  ) private var expenses: FetchedResults<Expense>
  
  
  @EnvironmentObject var budgetStore: BudgetStore
  @Environment(\.managedObjectContext) private var viewContext
  
  private var totalBudget: Double {
    budgets.reduce(0) { limit,  budget in
      budget.limit + limit
    }
  }
  
  private var totalSpent: Double {
      let spentAmount = expenses.reduce(0) { total, expense in
          total + (expense.amount * Double(expense.quantity))
      }
      return spentAmount
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
        HStack {
          Spacer()
          Text("Total Spent")
          Text(totalSpent, format: .currency(code: budgetStore.selectedCurrency))
            .foregroundStyle(totalSpent < totalBudget ? .black : .red)
          Spacer()
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


