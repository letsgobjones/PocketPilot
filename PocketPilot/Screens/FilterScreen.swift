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
  @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
  
  @State private var startPrice: Double?
  @State private var endPrice: Double?
  @State private var title: String = ""
  

    var body: some View {
      VStack(alignment: .leading, spacing: 20) {
        Section("Filter by Tags") {
          TagsView(selectedTags: $selectedTags)
            .onChange(of: selectedTags) { _, _ in
              filteredExpenses = budgetStore.filterTags(selectedTags: selectedTags,
                                                        context: viewContext
              )
            }
        }
        
        Section("Filter by Price") {
          TextField("Start Price", value: $startPrice, format: .number)
          TextField("End Price", value: $endPrice, format: .number)
          
          ActionButton(action: {
            filteredExpenses = budgetStore.filterByPrice(startPrice: startPrice, endPrice: endPrice, context: viewContext)
          }, label: "Search")
        }
        
        
        
        
        
        Section("Filter by Title") {
          ActionButton(action: {
            //
          }, label: "Search")
        }
        
        List(filteredExpenses) { expense in
          ExpenseCellView(expense: expense)
        }
        .listStyle(PlainListStyle())
        
        Spacer()
        
        HStack {
          Spacer()
          
          ActionButton(action: {
            selectedTags.removeAll()
            filteredExpenses = expenses.map { $0 }
          }, label: "Show All")
          Spacer()
        }
        
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




