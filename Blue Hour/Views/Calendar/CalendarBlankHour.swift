//
//  CalendarBlankHour.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 13/12/2021.
//

import SwiftUI

struct CalendarBlankHour: View {
    @EnvironmentObject var config: Config
    
    let time: String
    var bottom: Bool = false
    
    init(hour: Int){
        var hourString: String = "\(hour)"
        
        if hour < 10 {
            hourString = "0\(hour)"
        }
        
        if hour == 23 {
            bottom = true
        }
        
        time = "\(hourString):00"
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(time)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(config.theme.tabColor)
                Rectangle()
                    .fill(config.theme.tabBackground)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: 75)
            
            if bottom {
                HStack {
                    Text("00:00")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(config.theme.tabColor)
                    Rectangle()
                        .fill(config.theme.tabBackground)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }
}
