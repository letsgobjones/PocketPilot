//
//  ExpenseCellView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct ExpenseCellView: View {
  @EnvironmentObject var budgetStore: BudgetStore
  
  let expense: Expense
    var body: some View {
      HStack {
        Text(expense.title ?? "")
        Spacer()
        Text(expense.amount, format: .currency(code: budgetStore.selectedCurrency))
        
      }
    }
}

#Preview {
  NavigationStack {
    ExpenseCellView(expense: Budget.preview.expenses?.allObjects.first as! Expense)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore())
                .padding()
  }
}
