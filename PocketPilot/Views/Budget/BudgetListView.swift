//
//  BudgetListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct BudgetListView: View {
  @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
  var body: some View {
    
    List(budgets) { budget in
      NavigationLink {
        BudgetDetailScreen(budget: budget)
      } label: {
        BudgetCellView(budget: budget)
      }
    }
  }
}

#Preview {
  NavigationStack {
    BudgetListView()
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)

}


