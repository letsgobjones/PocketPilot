//
//  ContentView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject var budgetStore: BudgetStore

  @State private var isPresented: Bool = false
  @State private var isFilterPresented: Bool = false
  
    var body: some View {
      VStack {
        BudgetListView()
        
        ActionButton(action: {
          isFilterPresented.toggle()
        }, label: "Filter")
   
        CurrencyPickerView()
       
      }
      
      .padding()
      .listStyle(PlainListStyle())
      .navigationTitle("Pocket Pilot 🧑🏾‍✈️")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button("Add Budget") {
              isPresented = true
              budgetStore.errorMessage = nil
            }
          }
        }.sheet(isPresented: $isPresented, content: {
          AddBudgetScreen()
        })
        .sheet(isPresented: $isFilterPresented, content: {
          FilterScreen()
        })
    }
  }

#Preview {
  NavigationStack {
    ContentView()
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)

}
