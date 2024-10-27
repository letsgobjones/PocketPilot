//
//  AddBudgetScreen.swift
//  PocketPilot
//
//  Created by Brandon Jones on 10/27/24.
//

import SwiftUI

struct AddBudgetScreen: View {
  
  @State private var title: String = ""
  @State private var limit: Double?
  
  
  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
  }
  
  
  
    var body: some View {
      Form {
        Text("New Budget")
          .font(.title2)
          .fontWeight(.bold)
        
        TextField("Name", text: $title)
//          .presentationDetents([.medium])
        TextField("Limit", value: $limit, format: .number)
          .keyboardType(.numberPad)
        
        Button {
          //action
        } label: {
          Text("Save")
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .buttonStyle(.borderedProminent)
        .disabled(!isFormValid)
      }
      .presentationDetents([.medium])
    }
}

#Preview {
  NavigationStack {
    AddBudgetScreen()
  }
}
