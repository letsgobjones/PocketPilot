//
//  ButtonViews.swift
//  PocketPilot
//
//  Created by Brandon Jones on 11/9/24.
//

import SwiftUI

struct ActionButton: View {
  let action: () -> Void
  let label: String
  
  var body: some View {
    Button(action: action) {
      Text(label)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(.borderedProminent)
  }
}

#Preview {
  NavigationStack {
    ActionButton(action: {
      print("It Worked")
    }, label: "Label")
  }
  .padding()
  
}
