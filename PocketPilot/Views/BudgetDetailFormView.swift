//
//  BudgetDetailFormView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct BudgetDetailFormView: View {
  @EnvironmentObject private var budgetStore: BudgetStore

  @State private var title: String = ""
  @State private var amount: Double?
  
  let budget: Budget
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0
    
  }
  
    var body: some View {
      Form {
        Section("New Expense") {
          TextField("Title", text: $title)
          TextField("Amount", value: $amount, format: .number)
            .keyboardType(.numberPad)
          
          Button {
            budgetStore.addExpense(to: budget, title: title, amount: amount)
            title = ""
            amount = nil
            
          } label: {
            Text("Save")
              .frame(maxWidth: .infinity)
          }.buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
        }
        Section("Expenses") {
          List(budget.expenses?.allObjects as? [Expense] ?? []) { expense in
            Text(expense.title ?? "")
            
            
          }
          
          
        }
      }
    }
}

#Preview {
  var preview: Budget {
    let context = CoreDataProvider.preview.context
    let budget = Budget(context: context)
    budget.title = "Sample Budget"
    budget.limit = 500.00
    
    let milk = Expense(context: context)
    milk.title = "Milk"
    milk.amount = 5.50
    milk.dateCreated = Date()
    
    budget.addToExpenses(milk)
    return budget
  }

  NavigationStack {
    BudgetDetailFormView(budget: preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore(context: CoreDataProvider.preview.context))
  }
}
