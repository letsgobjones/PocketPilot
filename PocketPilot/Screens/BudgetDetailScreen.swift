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
    BudgetDetailFormView(budget: budget).navigationTitle(budget.title ?? "")
  }
}


#Preview {
  NavigationStack {
    BudgetDetailScreen(budget: Budget.preview)
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
      .environmentObject(BudgetStore(context: CoreDataProvider.preview.context))
  }
}
