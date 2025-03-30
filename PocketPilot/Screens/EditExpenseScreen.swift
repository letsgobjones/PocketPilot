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
  
  @Environment(\.managedObjectContext) private var viewContext
  
  
  let expense: Expense
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
  NavigationStack {
    EditExpenseScreen(expense: Expense.preview)
    
  }
//  .environment(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}


