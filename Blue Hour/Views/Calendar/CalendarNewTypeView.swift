//
//  CalendarNewTypeView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 13/12/2021.
//

import SwiftUI

struct CalendarNewTypeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var config: Config
    
    @State private var typeName: String = ""
    @State private var typeEmoji: String = ""
    
    private func createType(){
        withAnimation {
            let newType = CalendarItemType(context: viewContext)
            newType.name = typeName

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        List {
            TextField("Name", text: $typeName)
        }
        .background(config.theme.pageBackground)
        .navigationTitle("New Type")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Create"){
                createType()
            }
        }
    }
}
