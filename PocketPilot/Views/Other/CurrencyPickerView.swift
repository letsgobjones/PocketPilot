//
//  CurrencyPickerView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct CurrencyPickerView: View {
  
  @EnvironmentObject var budgetStore: BudgetStore
  
  var body: some View {
    Picker("Currency", selection: $budgetStore.selectedCurrency) {
      Text("USD").tag("USD")
      Text("KRW").tag("KRW")
    }
    .pickerStyle(SegmentedPickerStyle())
  }
}

#Preview {
  NavigationStack {
    CurrencyPickerView()
  }
  .environmentObject(BudgetStore())
}
