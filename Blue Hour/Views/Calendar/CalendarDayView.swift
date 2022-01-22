//
//  CalendarDayView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 13/12/2021.
//

import SwiftUI

struct CalendarDayView: View {
    @EnvironmentObject var config: Config
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selectedDate: Date?
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CalendarItem.start, ascending: true)],
        animation: .default
    )
    
    private var calendarEvents: FetchedResults<CalendarItem>
    
    var body: some View {
        if selectedDate != nil {
            VStack (spacing: 0) {
                ForEach(calendarEvents, id: \.self){event in
                    CalendarEvent(event: event)
                }
            }
        }
    }
}
