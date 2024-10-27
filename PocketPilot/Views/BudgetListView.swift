//
//  BudgetListView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct BudgetListView: View {
  
  @FetchRequest(sortDescriptors: [])  private var budgets: FetchedResults<Budget>
  var body: some View {
    VStack {
      List(budgets) { budgets in
        Text(budgets.title ?? "")
      }
    }
  }
}

#Preview {
  NavigationStack {
    BudgetListView()
      .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  }
}
