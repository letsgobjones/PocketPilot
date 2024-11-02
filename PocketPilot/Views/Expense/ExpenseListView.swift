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
  
  init(budget: Budget) {
      self.budget = budget
      _expenses = FetchRequest(
          entity: Expense.entity(),
          sortDescriptors: [], 
          predicate: NSPredicate(format: "budget == %@", budget)
      )
  }

  var body: some View {
    List(expenses) { expense in
      ExpenseCellView(expense: expense)
      
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



