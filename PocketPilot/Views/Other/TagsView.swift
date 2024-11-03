//
//  TagsView.swift
//  PocketPilot
//
//  Created by Brandon Jones on 11/3/24.
//

import SwiftUI
import CoreData

struct TagsView: View {
@FetchRequest(sortDescriptors: []) private var tags: FetchedResults<Tag>
  @State private var selectedTags: Set<Tag> = []
  
//  @Environment(\.managedObjectContext) private var viewContext
//
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(tags) { tag in
           Text(tag.name ?? "")
              .padding()
              .background(selectedTags.contains(tag) ? Color.blue : Color.gray)
              .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
              .onTapGesture {
                if selectedTags.contains(tag) {
                  selectedTags.remove(tag)
                } else {
                  selectedTags.insert(tag)
                }
              }
          }
        }.foregroundStyle(.white)
      }
    }
}

#Preview {
    NavigationStack {
      TagsView()
    }
    .padding()
    .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
