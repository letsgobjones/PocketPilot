//
//  BudgetDetailScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI
import CoreData

struct BudgetDetailScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @EnvironmentObject private var budgetStore: BudgetStore
  let budget: Budget
  
  @State private var title: String = ""
  @State private var amount: Double?
  @State private var quantity: Int?
  @State private var selectedTags: Set<Tag> = []
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace  && quantity != nil && Int(quantity!) > 0 && amount != nil && Double(amount!) > 0 && !selectedTags.isEmpty
  }
  
  var body: some View {
    Form {
      Section("New Expense") {
        TextField("Title", text: $title)
        TextField("Amount", value: $amount, format: .number)
          .keyboardType(.numberPad)
        TextField("Quantity", value: $quantity, format: .number)
          .keyboardType(.numberPad)
        TagsView(selectedTags: $selectedTags)
        
        Button(action: {
          budgetStore.addExpense(budget: budget, title: title, amount: amount, quantity: quantity, context: viewContext, tags: selectedTags)
          title = ""
          amount = nil
          quantity = nil
          selectedTags = []
        }, label: {
          Text("Save")
            .frame(maxWidth: .infinity)
        }).buttonStyle(.borderedProminent)
          .disabled(!isFormValid)
          .padding(.vertical, 5.0)
      }
      Section("Expenses") {
        ExpenseListView(budget: budget)
      }
    }
    
    .navigationTitle(budget.title ?? "")
    .toolbar {
      ToolbarItem(placement: .principal) {
        Text(budget.limit, format: .currency(code: budgetStore.selectedCurrency))
      }
    }
  }
}



#Preview {
  NavigationStack {
    BudgetDetailScreen(budget: Budget.preview)
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
