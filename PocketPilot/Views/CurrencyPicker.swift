//
//  CurrencyPicker.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct CurrencyPicker: View {
  
  @EnvironmentObject var budgetStore: BudgetStore
  
    var body: some View {
      Picker("Currency", selection: $budgetStore.selectedCurrency) {
                      Text("USD").tag("USD")
                      Text("KRW").tag("KRW")
                      // Add more currencies as needed
                  }
                  .pickerStyle(SegmentedPickerStyle())
      
    }
}

#Preview {
  NavigationStack {
    CurrencyPicker()
      .environmentObject(BudgetStore(context: CoreDataProvider.preview.context))

    
  }
}
