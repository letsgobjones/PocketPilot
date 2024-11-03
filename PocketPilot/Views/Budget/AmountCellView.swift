//
//  AmountCellView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 11/3/24.
//

import SwiftUI
import CoreData

struct AmountCellView<T: NSManagedObject>: View {
    @EnvironmentObject var budgetStore: BudgetStore
    
    let item: T
    let title: String
    let value: Double
    
    init(item: T, title: String?, value: Double) {
        self.item = item
        self.title = title ?? ""
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value, format: .currency(code: budgetStore.selectedCurrency))
        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            // For Budget
            AmountCellView(
                item: Budget.preview,
                title: Budget.preview.title,
                value: Budget.preview.limit
            )
            
            // For Expense
            if let expense = Budget.preview.expenses?.allObjects.first as? Expense {
                AmountCellView(
                    item: expense,
                    title: expense.title,
                    value: expense.amount
                )
            }
        }
        .padding()
    }
    .environmentObject(BudgetStore())
    .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
