//
//  EditExpenseScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 3/30/25.
//

import SwiftUI

struct EditExpenseScreen: View {
  @FetchRequest(
    entity: Expense.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Expense.dateCreated, ascending: false)]
  ) private var expenses: FetchedResults<Expense>
  
  @Bindable var budgetStore: BudgetStore
  @Environment(\.managedObjectContext) private var viewContext
  let expense: Expense
  
  @State private var expenseTitle: String = ""
  @State private var expenseAmount: Double?
  @State private var expenseQuantity: Int = 0
  @State private var expenseSelectedTags: Set<Tag> = []
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Title", text: $expenseTitle)
        TextField("Amount", value: $expenseAmount, format: .number)
        TextField("Quantity", value: $expenseQuantity, format: .number)
        TagsView(selectedTags: $expenseSelectedTags)
      }
      .onAppear{
        expenseTitle = expense.title ?? ""
        expenseAmount = expense.amount
        expenseQuantity = Int(expense.quantity)
        if let tags = expense.tags {
          expenseSelectedTags = Set(tags.compactMap{$0 as? Tag})
        }
      }
      
      
      
      
     
    }.toolbar(content: {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Update") {
          budgetStore.updateExpense(expense: expense, title: expenseTitle, amount: expenseAmount, quantity: expenseQuantity, tags: expenseSelectedTags, context: viewContext)
        }
      }
    })
    .navigationTitle(expense.title ?? "")
  }
}

#Preview {
  NavigationStack {
    EditExpenseScreen(budgetStore: BudgetStore(), expense: Expense.preview)
    
  }
//  .environment(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}


