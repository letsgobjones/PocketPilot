//
//  TagsSeeder.swift
//  PocketPilot
//
//  Created by Brandon Jones on 11/3/24.
//

import Foundation
import CoreData

class TagsSeeder {
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
  
  func seed(_ commonTags: [String]) throws {
    for commonTag in commonTags {
      let tag = Tag(context: context)
      tag.name = commonTag
   
        try context.save()
      
      }
    }
  }

