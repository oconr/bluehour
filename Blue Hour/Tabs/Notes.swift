//
//  Notes.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI

struct NotesTab: View {
    @EnvironmentObject var config: Config
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .background(config.theme.pageBackground)
            .navigationTitle("Notes")
        }
    }
}
