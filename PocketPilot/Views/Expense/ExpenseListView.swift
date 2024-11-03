//
//  ExpenseListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI
import CoreData

struct ExpenseListView: View {
  let budget: Budget
  @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
  @EnvironmentObject var budgetStore: BudgetStore

  private var total: Double {
    return expenses.reduce(0) { result, expense in
      expense.amount + result}
  }
  
  private var remaining: Double {
    budget.limit - total
  }
  
  
  init(budget: Budget) {
      self.budget = budget
      _expenses = FetchRequest(
          entity: Expense.entity(),
          sortDescriptors: [], 
          predicate: NSPredicate(format: "budget == %@", budget)
      )
  }

  var body: some View {
    List {
      VStack() {
        HStack {
          Spacer()
          Text("Total")
          Text(total, format: .currency(code: budgetStore.selectedCurrency))
          Spacer()
        }
        HStack {
          Spacer()
          Text("Remaining")
          Text(remaining, format: .currency(code: budgetStore.selectedCurrency))
            .foregroundStyle(remaining < 0 ? .red : .green)
          Spacer()
        }
      }
      
      ForEach(expenses) { expense in
//        ExpenseCellView(expense: expense)
        AmountCellView(item: expense, title: expense.title, value: expense.amount)
        
      }
    }
  }
}

#Preview {
  NavigationStack {
    ExpenseListView(budget: Budget.preview )
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)

}



