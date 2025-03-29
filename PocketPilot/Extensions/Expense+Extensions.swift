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
}
