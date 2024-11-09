//
//  FilterScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 11/3/24.
//

import SwiftUI

struct FilterScreen: View {
  @EnvironmentObject var budgetStore: BudgetStore
  @Environment(\.managedObjectContext) private var viewContext
  @State private var selectedTags: Set<Tag> = []
  @State private var filteredExpenses: [Expense] = []
  
  var body: some View {
    VStack(alignment: .leading) {
      Section("Filter by Tags") {
        TagsView(selectedTags: $selectedTags)
          .onChange(of: selectedTags) { _, _ in
            filteredExpenses = budgetStore.filterTags(selectedTags: selectedTags,
                                                      context: viewContext
            )
          }
      }
        
        List(filteredExpenses) { expense in
          ExpenseCellView(expense: expense)

        }
        
        Spacer()
      }
      .padding()
      .navigationTitle("Filter")
    }
  }


#Preview {
  NavigationStack {
    FilterScreen()
  }
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  .environmentObject(BudgetStore())
  
  
}




