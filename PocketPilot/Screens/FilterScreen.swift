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
  
  @State private var startPrice: Double?  //
  @State private var endPrice: Double?  //
  @State private var title: String = ""
  @State private var startDate = Date()
  @State private var endDate = Date()
  
  @State private var selectedSortOptions: SortingOptions? = nil
  @State private var selectedSortDirection: SortingDirection = .ascending
  @State private var selectedFilterOption: FilterOptions? = nil
  
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
          }
          
          Picker("Sorting Direction", selection: $selectedSortDirection) {
            ForEach(SortingDirection.allCases) { direction in
              Text(direction.title)
                .tag(direction)
            }
          }
          ActionButton(action: {
            filteredExpenses = budgetStore.performSort(selectedSortOptions: selectedSortOptions, selectedSortDirection: selectedSortDirection, context: viewContext)
          }, label: "Sort")
        }
        
        Section("Filter by Tags") {
          TagsView(selectedTags: $selectedTags)
            .onChange(of: selectedTags, {
              selectedFilterOption = .byTags(selectedTags)
              
            })
        }
  
        Section("Filter by Price") {
          TextField("Start Price", value: $startPrice, format: .number)
          TextField("End Price", value: $endPrice, format: .number)
          
          ActionButton(action: {
            guard let startPrice = startPrice,
                    let endPrice = endPrice else { return }
            selectedFilterOption = .byPriceRange(minPrice: startPrice, maxPrice: endPrice)
            
            
          }, label: "Search")
        }
        
        Section("Filter by Title") {
          TextField("Title", text: $title)
          ActionButton(action: {
selectedFilterOption = .byTitle(title)
          }, label: "Search")
        }
        
        
        Section("Filter by Date") {
          DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
          DatePicker("End Date", selection: $endDate, displayedComponents: .date)
          ActionButton(action: {
selectedFilterOption = .byDate(startDate: startDate, endDate: endDate)
          }, label: "Search")
        }
        
        Section("Expenses") {
          ForEach(filteredExpenses) { expense in
            ExpenseCellView(expense: expense)
          }
          .listStyle(PlainListStyle())
        }
      }

      .onChange(of: selectedFilterOption) { filteredExpenses = budgetStore.performFilter(selectedFilterOption: selectedFilterOption, context: viewContext) }
      
      
      .listStyle(PlainListStyle())
      .navigationTitle("Filter")
      
      
      ActionButton(action: {
        selectedTags.removeAll()
        selectedFilterOption = FilterOptions.none
      }, label: "Show All")
      
      
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




