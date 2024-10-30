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
  NavigationStack {
    BudgetCellView(budget: Budget.preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore(context: CoreDataProvider.preview.context))

      .padding()
  }
}
