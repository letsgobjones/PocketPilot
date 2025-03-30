//
//  Expense+Extensions.swift
//  PocketPilot
//
//  Created by Brandon Jones on 3/29/25.
//

import Foundation
import CoreData


extension Expense {
  var total: Double {
    amount * Double(quantity)
  }
  
  
  static var preview: Expense {
    let context = CoreDataProvider.preview.context
    let expense = Expense(context: context)
    expense.title = "Sample Expense"
    expense.amount = 10.50
    expense.quantity = 2
    expense.dateCreated = Date()

    return expense
  }
  
  
 static func exists(context: NSManagedObjectContext, title: String) -> Bool {
    let request = Expense.fetchRequest()
    request.predicate = NSPredicate(format: "title == %@", title)
    do {
      let results = try context.fetch(request)
      return !results.isEmpty
    } catch {
      return false
    }
  }

  
  
  
}
