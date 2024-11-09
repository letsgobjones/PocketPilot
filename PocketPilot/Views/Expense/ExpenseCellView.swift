//
//  ExpenseCellView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

struct ExpenseCellView: View {
  @EnvironmentObject var budgetStore: BudgetStore
  
  let expense: Expense
  
  var body: some View {
    VStack {
      
      
      HStack {
        Text(expense.title ?? "")
        Spacer()
        Text(expense.amount, format: .currency(code: budgetStore.selectedCurrency))
        
      }
      
      
      //      ExpenseTagsView()
      
      
      ScrollView(.horizontal) {
        HStack {
          ForEach(Array(expense.tags as? Set<Tag> ?? []), id: \.self) { tag in
            Text(tag.name ?? "")
              .font(.caption)
              .padding(.vertical, 5.0)
              .padding(.horizontal, 10.0)
              .foregroundStyle(.white)
              .background(.blue)
              .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          }
          
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    ExpenseCellView(expense: Budget.preview.expenses?.allObjects.first as! Expense)
                .padding()
  }
  .environmentObject(BudgetStore())
  .environment(\.managedObjectContext, CoreDataProvider.preview.context)

}
