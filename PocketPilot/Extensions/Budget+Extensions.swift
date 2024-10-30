//
//  Budget+Extensions.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/30/24.
//

import SwiftUI

extension Budget { 
    static var preview: Budget {
        let context = CoreDataProvider.preview.context
        let budget = Budget(context: context)
        budget.title = "Sample Budget"
        budget.limit = 500.00

        let milk = Expense(context: context)
        milk.title = "Sample Expense"
        milk.amount = 10.50
        milk.dateCreated = Date()

        budget.addToExpenses(milk)
        return budget
    }
}
