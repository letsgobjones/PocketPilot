//
//  BudgetCellView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//



import SwiftUI


struct BudgetCellView: View {
  @EnvironmentObject var budgetStore: BudgetStore

  let budget: Budget
  
  var body: some View {
    HStack {
      Text(budget.title ?? "")
      Spacer()
//      Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
      Text(budget.limit, format: .currency(code: budgetStore.selectedCurrency))

    }
  }
}




#Preview {
  
   var preview: Budget {
     let context = CoreDataProvider.preview.context
     let budget = Budget(context: context)
       budget.title = "Sample Budget"
       budget.limit = 500.00
       return budget
   }
  
  
  NavigationStack {
    BudgetCellView(budget: preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore(context: CoreDataProvider.preview.context))

      .padding()
  }
}
