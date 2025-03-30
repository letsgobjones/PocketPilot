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
//  @EnvironmentObject var budgetStore: BudgetStore
  @Bindable var budgetStore: BudgetStore


  @Environment(\.managedObjectContext) private var viewContext
  @State private var expenseToEdit: Expense?
  
  private var total: Double {
    return expenses.reduce(0) { result, expense in
     result + (expense.amount * Double(expense.quantity))}
  }
  
  private var remaining: Double {
    budget.limit - total
  }
  
  init(budget: Budget, budgetStore: BudgetStore) {
    self.budget = budget
    self.budgetStore = budgetStore

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
      
      if expenses.isEmpty {
        HStack {
          Spacer()
          Text("Please add an expense to get started.")
          Spacer()
        }
      } else {
        
        ForEach(expenses) { expense in
          ExpenseCellView(budgetStore: budgetStore, expense: expense)
            .onLongPressGesture {
              expenseToEdit = expense
            }
        }
        .onDelete { indexSet in
          budgetStore.deleteExpense( indexSet, expenses: Array(expenses), context: viewContext)
        }
      }
    }.sheet(item: $expenseToEdit) { expenseToEdit in
      NavigationStack {
        EditExpenseScreen(budgetStore: budgetStore, expense: expenseToEdit)
      }
    }
  }
}


#Preview {
  NavigationStack {
    ExpenseListView(budget: Budget.preview, budgetStore: BudgetStore())
  }
//  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  
}



