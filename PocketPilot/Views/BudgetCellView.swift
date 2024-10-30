//
//  BudgetCellView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//



import SwiftUI


struct BudgetCellView: View {
  let budget: Budget
  
  var body: some View {
    HStack {
      Text(budget.title ?? "")
      Spacer()
      Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
    }
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
    BudgetCellView(budget: preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .padding()
  }
}
