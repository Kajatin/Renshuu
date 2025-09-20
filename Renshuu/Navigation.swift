//
//  Navigation.swift
//  Renshuu
//
//  Created by Roland Kajatin on 05/09/2025.
//

import SFSymbolsPicker
import SwiftData
import SwiftUI

struct Navigation: View {
    @Query(sort: \Collection.createdOn, order: .reverse) var collections: [Collection]

    @State private var selectedCollection: Collection? = nil
    @State private var showNewCollectionSheet = false
    @State private var icon = "star.fill"
    
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationSplitView {
            List(collections, selection: $selectedCollection) { collection in
                HStack {
                    Image(systemName: collection.icon)
                    Text(collection.title)
                }
                .tag(collection)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewCollectionSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
//                    NavigationLink(destination: CreateNewRenshuu(collection: collection)) {
//                        Image(systemName: "plus")
//                    }
                }
            }
            .navigationTitle("Collections")
        } detail: {
            if (selectedCollection != nil) {
                ContentView(collection: selectedCollection!)
            } else {
                Text("Select collection")
            }
        }
        .sheet(isPresented: $showNewCollectionSheet) {
            if let collection = selectedCollection {
                CreateNewRenshuu(collection: collection)
            } else {
                SymbolsPicker(selection: $icon, title: "Pick a symbol", autoDismiss: true)
            }
        }
        .onAppear {
            modelContext.insert(Collection(title: "Default"))
            modelContext.insert(Collection(title: "Danish"))
        }
    }
}

#Preview {
    Navigation()
        .modelContainer(for: [Collection.self, Renshuu.self], inMemory: true)
}
