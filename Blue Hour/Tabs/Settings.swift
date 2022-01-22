//
//  Settings.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI

struct SettingsTab: View {
    @EnvironmentObject var config: Config
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Day Start")){
                        Text("Custom Day Start")
                    }
                    
                    Section(header: Text("Calendar")){
                        NavigationLink(destination: SettingsCalendarTypesView()){
                            Text("Event Types")
                        }
                    }
                    
                    Section(header: Text("Preferences")){
                        Text("Language")
                        Text("Launch Screen")
                        NavigationLink(destination: SettingsTheme()){
                            Text("Theme")
                        }
                        Text("App Icon")
                    }
                    
                    Section(header: Text("About")){
                        Text("News")
                        Text("Support")
                        Text("About")
                    }
                }
                .listStyle(.insetGrouped)
            }
            .background(config.theme.pageBackground)
            .navigationTitle("Settings")
        }
        .accentColor(config.theme.tabColor)
    }
}
