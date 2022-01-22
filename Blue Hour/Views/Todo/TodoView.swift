//
//  TodoView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI
import CoreData

struct TodoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var config: Config
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.timestamp, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<ToDoItem>
    
    private func addItem(){
        withAnimation {
            let newItem = ToDoItem(context: viewContext)
            newItem.value = "hello world"
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet){
        withAnimation {
            offsets.map {
                items[$0]
            }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(items){ item in
                Text(item.value ?? "")
            }
            .onDelete(perform: deleteItems)
        }
        .frame(maxWidth: .infinity)
        .background(config.theme.pageBackground)
        .toolbar {
            Button(action: addItem){
                Label("Add Item", systemImage: "plus")
            }
        }
        .navigationTitle("To Do")
    }
}
