//
//  AddBudgetScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct AddBudgetScreen: View {
  @Environment(\.managedObjectContext) private var viewContext
  
//  @EnvironmentObject var budgetStore: BudgetStore
  @Bindable var budgetStore: BudgetStore


  
  @State private var title: String = ""
  @State private var limit: Double?
  
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
  }
  
  var body: some View {
    Form {
      Text("New Budget")
        .font(.title2)
        .fontWeight(.bold)
      
      TextField("Name", text: $title)
      TextField("Limit", value: $limit, format: .number)
        .keyboardType(.numberPad)
      
      Button {
        if !Budget.exists(context: viewContext, title: title) {
          budgetStore.saveBudget(title: title, limit: limit, context: viewContext)
        } else {
          budgetStore.errorMessage = .budgetAlreadyExists
          
        }
      } label: {
        Text("Save")
          .frame(maxWidth: .infinity)
      }
      .padding(.vertical)
      .buttonStyle(.borderedProminent)
      .disabled(!isFormValid)
      
      Text(budgetStore.errorMessage?.localizedDescription ?? "")
    }
    .presentationDetents([.medium])
  }
}

#Preview {
  NavigationStack {
    AddBudgetScreen(budgetStore: BudgetStore())
  }
//  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider(inMemory: true).context)
  
}
