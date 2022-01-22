//
//  CalendarEvent.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 14/12/2021.
//

import SwiftUI

struct CalendarEvent: View {
    var event: CalendarItem
    
    var viewHeight: CGFloat
    
    init(event: CalendarItem){
        print("hello world")
        print(event)
        if !event.allDay {
            let difference = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .hour, .minute], from: event.start!, to: event.end!)
            print(difference)
        }
        
        viewHeight = 0
        
        self.event = event
    }
    
    var body: some View {
        VStack {
            
        }
    }
}
