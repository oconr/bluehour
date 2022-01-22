//
//  ContentView.swift
//  BlueHour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI
import CoreData

enum Tabs {
    case calendar
    case todo
    case notes
    case settings
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var config: Config
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {geometry in
            ZStack (alignment: .bottom) {
                ZStack {
                    CalendarTab()
                        .opacity(config.selectedTab == .calendar ? 1 : 0)
                        .offset(x: config.selectedTab == .calendar ? 0 : -50, y: 0)
                    
                    TodoTab()
                        .opacity(config.selectedTab == .todo ? 1 : 0)
                        .offset(x: config.selectedTab == .todo ? 0 : config.selectedTab == .calendar ? 50 : -50, y: 0)
                    
                    NotesTab()
                        .opacity(config.selectedTab == .notes ? 1 : 0)
                        .offset(x: config.selectedTab == .notes ? 0 : config.selectedTab == .settings ? -50 : 50, y: 0)
                    
                    SettingsTab()
                        .opacity(config.selectedTab == .settings ? 1 : 0)
                        .offset(x: config.selectedTab == .settings ? 0 : 50)
                }
                .edgesIgnoringSafeArea(.bottom)
                
                HStack {
                    ZStack (alignment: .center){
                        if config.selectedTab == .calendar {
                            Circle()
                                .fill(config.theme.tabColor)
                                .frame(width: 40, height: 40)
                                .matchedGeometryEffect(id: "selected", in: animation)
                        }
                        
                        Image(systemName: "calendar")
                            .animatableSystemFont(size: config.selectedTab == .calendar ? 18 : 24)
                            .foregroundColor(config.selectedTab == .calendar ? config.theme.tabColorActive : config.theme.tabColor)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2)){
                                    config.setTab(.calendar)
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    
                    ZStack (alignment: .center){
                        if config.selectedTab == .todo {
                            Circle()
                                .fill(config.theme.tabColor)
                                .frame(width: 40, height: 40)
                                .matchedGeometryEffect(id: "selected", in: animation)
                        }
                        
                        Image(systemName: "checklist")
                            .animatableSystemFont(size: config.selectedTab == .todo ? 18 : 24)
                            .foregroundColor(config.selectedTab == .todo ? config.theme.tabColorActive : config.theme.tabColor)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2)){
                                    config.setTab(.todo)
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    
                    ZStack (alignment: .center){
                        if config.selectedTab == .notes {
                            Circle()
                                .fill(config.theme.tabColor)
                                .frame(width: 40, height: 40)
                                .matchedGeometryEffect(id: "selected", in: animation)
                        }
                        
                        Image(systemName: "note.text")
                            .animatableSystemFont(size: config.selectedTab == .notes ? 18 : 24)
                            .foregroundColor(config.selectedTab == .notes ? config.theme.tabColorActive : config.theme.tabColor)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2)){
                                    config.setTab(.notes)
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    
                    ZStack (alignment: .center){
                        if config.selectedTab == .settings {
                            Circle()
                                .fill(config.theme.tabColor)
                                .frame(width: 40, height: 40)
                                .matchedGeometryEffect(id: "selected", in: animation)
                        }
                        
                        Image(systemName: "gearshape.fill")
                            .animatableSystemFont(size: config.selectedTab == .settings ? 18 : 24)
                            .foregroundColor(config.selectedTab == .settings ? config.theme.tabColorActive : config.theme.tabColor)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2)){
                                    config.setTab(.settings)
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(width: geometry.size.width - 50, height: 60)
                .background(config.theme.tabBackground)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 15)
                .padding(.horizontal, 25)
                .offset(x: 0, y: -geometry.safeAreaInsets.bottom)
            }
            .background(config.theme.pageBackground)
            .edgesIgnoringSafeArea(.bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
