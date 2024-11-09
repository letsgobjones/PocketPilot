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
  
  
//  func filterByPrice() {
//    guard let startPrice,
//          let endPrice else { return }
//    
//    let request = Expense.fetchRequest()
//    request.predicate = NSPredicate(format: "amount >= %@ && amount <= %@", NSNumber(value: startPrice), NSNumber(value: endPrice))
//    do {
//      filteredExpenses = try viewContext.fetch(request)
//    } catch {
//      print(error)
//    }
//  }
    
    
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
          
          Button {
            filteredExpenses = budgetStore.filterByPrice(startPrice: startPrice, endPrice: endPrice, context: viewContext)
          } label: {
            Text("Search")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
        }
        
        
        
        List(filteredExpenses) { expense in
          ExpenseCellView(expense: expense)
        }
        
        Spacer()
        
        HStack {
          Spacer()
          Button {
            selectedTags.removeAll()
            filteredExpenses = expenses.map { $0 }
          } label: {
            Text("Show All")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
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




