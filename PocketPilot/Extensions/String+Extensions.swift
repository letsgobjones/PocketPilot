//
//  String+Extensions.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import Foundation

extension String {
  
  var isEmptyOrWhitespace: Bool {
    trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
