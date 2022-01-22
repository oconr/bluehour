//
//  CalendarNewEventView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 13/12/2021.
//

import SwiftUI

struct CalendarNewEventView: View {
    @EnvironmentObject var config: Config
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CalendarItemType.name, ascending: true)], animation: .default)
    private var calendarItemTypes: FetchedResults<CalendarItemType>
    
    @State var eventName: String = ""
    @State var eventLocation: String = ""
    @State var eventAllDay: Bool = false
    @State var eventStartDate: Date = Date.now
    @State private var eventEndDate: Date = Date.now
    
    @State private var eventType: CalendarItemType = CalendarItemType()
    
    private func loadTypes(){
        eventType = calendarItemTypes[0]
    }
    
    @State private var eventHasType: Bool = true
    
    private func createEvent(){
        withAnimation {
            let newEvent = CalendarItem(context: viewContext)

            newEvent.allDay = eventAllDay

            if !eventAllDay {
                newEvent.start = eventStartDate
                newEvent.end = eventEndDate
            }

            newEvent.name = eventName
            newEvent.location = eventLocation

            if eventHasType {
                newEvent.type = eventType
            }

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Details")) {
                    TextField("Name", text: $eventName)
                    TextField("Location", text: $eventLocation)
                }
                
                Section(header: Text("Times")) {
                    Toggle(isOn: $eventAllDay){
                        Text("All-day")
                    }
                    .tint(config.theme.tabColor)
                    DatePicker("Starts", selection: $eventStartDate, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Ends", selection: $eventEndDate, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section(header: Text("Type")) {
                    Toggle(isOn: $eventHasType){
                        Text("Add type?")
                    }.tint(config.theme.tabColor)
                    
                    if (eventHasType){
                        if !calendarItemTypes.isEmpty {
                            Picker("Type", selection: $eventType){
                                ForEach(calendarItemTypes, id: \.self){type in
                                    Text(type.name ?? "").tag(type)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .clipped()
                        }
                        
                        NavigationLink(destination: CalendarNewTypeView()){
                            Text("Add a new type")
                        }
                    }
                }
                
                
            }
            .listStyle(.insetGrouped)
            .background(config.theme.pageBackground)
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Create"){
                        createEvent()
                    }
                }
            }
        }
        .accentColor(config.theme.tabColor)
        .onAppear {
            self.loadTypes()
        }
    }
}
