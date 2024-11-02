//
//  BudgetDetailScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI
import CoreData

struct BudgetDetailScreen: View {
  @Environment(\.managedObjectContext) private var viewContext

  @EnvironmentObject private var budgetStore: BudgetStore
  let budget: Budget
  
  @State private var title: String = ""
  @State private var amount: Double?

  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0
  }
  
  var body: some View {
    Form {
      Section("New Expense") {
        TextField("Title", text: $title)
        TextField("Amount", value: $amount, format: .number)
          .keyboardType(.numberPad)
        
        Button(action: {
          budgetStore.addExpense(budget: budget, title: title, amount: amount, context: viewContext)
          title = ""
          amount = nil
        }, label: {
          Text("Save")
            .frame(maxWidth: .infinity)
        }).buttonStyle(.borderedProminent)
          .disabled(!isFormValid)
      }
      Section("Expenses") {
        ExpenseListView(budget: budget)
      }
    }
    .navigationTitle(budget.title ?? "")
  }
}


#Preview {
    NavigationStack {
        BudgetDetailScreen(budget: Budget.preview)
    }
    .environmentObject(BudgetStore())
    .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}






//
//#Preview {
//    NavigationStack {
//      BudgetDetailScreen(budget: Budget.preview)
//        .environment(\.managedObjectContext, CoreDataProvider(inMemory: true).context)
//                    .environmentObject(BudgetStore())
//    }
//}





//struct BudgetDetailScreenContainer: View {
//
//    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
//
//    var body: some View {
//      // Safely unwrap the optional budget
//              if let groceriesBudget = budgets.first(where: { $0.title == "Groceries" }) {
//                  BudgetDetailScreen(budget: groceriesBudget)
//              } else {
//                  // Handle the case where the "Groceries" budget is not found
//                  Text("Groceries budget not found") // Or any other appropriate view
//              }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        BudgetDetailScreen(budget: Budget.preview) // Use Budget.preview directly
//            .environment(\.managedObjectContext, CoreDataProvider(inMemory: true).context)
//            .environmentObject(BudgetStore())
//    }
//}
