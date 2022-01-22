//
//  Theme.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI

struct SettingsTheme: View {
    @EnvironmentObject var config: Config
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            ScrollView {
                Text("Theme settings goes here")
            }
            .padding(.top, 100)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .navigationTitle("Theme")
            
            HStack {
                
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.red)
        }
        .background(config.theme.pageBackground)
    }
}
