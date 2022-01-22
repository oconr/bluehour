//
//  SettingsCalendarTypesView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 13/12/2021.
//

import SwiftUI

struct SettingsCalendarTypesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var config: Config
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CalendarItemType.name, ascending: true)],
        animation: .default
    )
    private var eventTypes: FetchedResults<CalendarItemType>
    
    private func deleteType(offsets: IndexSet){
        withAnimation {
            offsets.map {
                eventTypes[$0]
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
            if eventTypes.isEmpty {
                Text("You don't have any event types")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(config.theme.tabBackground)
            } else {
                ForEach(eventTypes, id: \.self){type in
                    Text(type.name ?? "")
                }
                .onDelete(perform: deleteType)
            }
        }
        .listStyle(.insetGrouped)
        .background(config.theme.pageBackground)
        .navigationTitle("Event Types")
        .toolbar {
            NavigationLink(destination: CalendarNewTypeView()){
                Image(systemName: "plus")
            }
        }
    }
}
