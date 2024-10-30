//
//  BudgetDetailScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct BudgetDetailScreen: View {
  @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
  @EnvironmentObject private var budgetStore: BudgetStore
  let budget: Budget
  
  @State private var title: String = ""
  @State private var amount: Double?
  
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
//          addExpenese()
          
        } label: {
          Text("Save")
            .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
          .disabled(!isFormValid)
      }
    }.navigationTitle(budget.title ?? "")
  }
}


#Preview {
  
  var preview: Budget {
    let budget = Budget(context: CoreDataProvider.preview.context)
    budget.title = "Sample Budget"
    budget.limit = 500.00
    return budget
  }
  
  NavigationStack {
    BudgetDetailScreen(budget: preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  }
}
