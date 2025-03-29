//
//  MigrationPolicy_V1_to_V2.swift
//  PocketPilot
//
//  Created by Brandon Jones on 3/29/25.
//

import Foundation
import CoreData

class MirgationPolicy_V1_to_V2: NSEntityMigrationPolicy {
  
  override func begin(_ mapping: NSEntityMapping, with manager: NSMigrationManager) throws {
   
    var titles: [String] = []
    var index: Int = 1
    
    let context = manager.sourceContext
    let expenseRequest = Expense.fetchRequest()
    
    let results: [NSManagedObject] = try context.fetch(expenseRequest)
   
    for result in results {
      
      guard let title = result.value(forKey: "title") as? String else { continue }
      if !titles.contains(title) {
        titles.append(title)
      } else {
        
        //delete the duplicate
        //context.delete(result)
        
        
        let uniqueTitle = title + "\(index)"
        index += 1
        result.setValue(uniqueTitle, forKey: "title")
      }
    }
   
  }
}
