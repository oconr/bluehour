//
//  Config.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI
import Foundation

class Config: ObservableObject {
    @Published var selectedTab: Tabs = .calendar
    @Published var theme: Theme = getTheme(UserDefaults.standard.string(forKey: "theme"))
    
    public func setTab(_ tab: Tabs){
        selectedTab = tab
    }
    
    public func setTheme(_ theme: Theme){
        self.theme = theme
        UserDefaults.standard.set(theme.name, forKey: "theme")
    }
}
