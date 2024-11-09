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
  @State private var startDate = Date()
  @State private var endDate = Date()
  @State private var selectedSortOptions: SortingOptions? = nil

  

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      List {
        
        Section("Sort") {
          Picker("Sort Options", selection: $selectedSortOptions) {
            Text("Select").tag(Optional<SortingOptions>(nil))
            ForEach(SortingOptions.allCases) { option in
              Text(option.title)
                .tag(Optional(option))
              
            }
          }.onChange(of: selectedSortOptions) {
            filteredExpenses = budgetStore.performSort(selectedSortOptions: selectedSortOptions, context: viewContext)
          }
        }
        
        
        
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
          TextField("Title", text: $title)
          ActionButton(action: {
            filteredExpenses = budgetStore.filterByTitle(title: title, context: viewContext)
          }, label: "Search")
        }
        
        
        Section("Filter by Date") {
          DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
          DatePicker("End Date", selection: $endDate, displayedComponents: .date)
          ActionButton(action: {
            filteredExpenses = budgetStore.filterByDate(startDate: startDate, endDate: endDate, context: viewContext)
          }, label: "Search")
        }
        
        
        
        Section("Expenses") {
          
          
          ForEach(filteredExpenses) { expense in
            ExpenseCellView(expense: expense)
          }
          .listStyle(PlainListStyle())
        }
      }
      .listStyle(PlainListStyle())
      .navigationTitle("Filter")
      
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
  }
}


#Preview {
  NavigationStack {
    FilterScreen()
  }
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)
  .environmentObject(BudgetStore())
  
  
}




