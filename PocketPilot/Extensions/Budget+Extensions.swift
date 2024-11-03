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
    
    let expense1 = Expense(context: context)
    expense1.title = "Sample Expense 1"
    expense1.amount = 10.50
    expense1.dateCreated = Date()
    
    let expense2 = Expense(context: context)
    expense2.title = "Sample Expense 2"
    expense2.amount = 4.50
    expense2.dateCreated = Date()
    
    
    budget.addToExpenses(expense1)
    budget.addToExpenses(expense2)

    let tag1 = Tag(context: context)
    tag1.name = "Sample Tag 1"
    
    let tag2 = Tag(context: context)
    tag2.name = "Sample Tag 2"
    
    expense1.addToTags(tag1)
    expense2.addToTags(tag2)
    
    
    
    return budget
  }
}
