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
  @Binding var selectedTags: Set<Tag>
  
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(tags) { tag in
           Text(tag.name ?? "")
              .padding(.vertical, 5.0)
              .padding(.horizontal, 10.0)
              .background(selectedTags.contains(tag) ? Color.blue : Color.gray)
              .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
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
      TagsView(selectedTags: .constant(Set<Tag>()))
    }
    .padding()
    .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
