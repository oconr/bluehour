//
//  CalendarWeeklyView.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI
import Foundation
import SwiftUIPager

struct CalendarWeeklyView: View {
    @Namespace private var animation
    @EnvironmentObject var config: Config
    @State private var daysOfWeek: [Date] = []
    @State private var prevWeek: [Date] = []
    @State private var nextWeek: [Date] = []
    @State private var currentWeekStart: Date? = nil
    
    @State private var selectedDate: Date? = nil
    @State private var weekSwipeValue: CGFloat = .zero
    @State private var weekSwipeAnim: CGFloat = .zero
    
    @State private var newEventShowing: Bool = false
    
    private func loadCalendar(_ date: Date){
        self.daysOfWeek = []
        
        for i in 0...6 {
            let cal = Calendar.autoupdatingCurrent
            let newDate = cal.date(byAdding: .day, value: i, to: startOfWeek(date))
            
            self.daysOfWeek.append(newDate!)
            
            let today = cal.startOfDay(for: date)
            
            if newDate == today {
                self.selectedDate = newDate
            }
        }
    }
    
    let months = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    private func formatDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    private func startOfWeek(_ date: Date) -> Date {
        let cal = Calendar.autoupdatingCurrent
        let start = cal.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: date).date!
        
        return start
    }
    
    private func changeDate(_ date: Date){
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2)){
            self.selectedDate = date
        }
    }
    
    private func changeWeek(_ direction: Int){
        if direction == 1 {
            // next week
            
            let cal = Calendar.autoupdatingCurrent
            let newDate = cal.date(byAdding: .day, value: 7, to: self.selectedDate!)
            
            self.currentWeekStart = self.startOfWeek(newDate!)
            self.loadCalendar(newDate!)
            
            return
        }
        
        if direction == -1 {
            // prev week
            
            let cal = Calendar.autoupdatingCurrent
            let newDate = cal.date(byAdding: .day, value: -7, to: self.selectedDate!)
            
            self.currentWeekStart = self.startOfWeek(newDate!)
            self.loadCalendar(newDate!)
            
            return
        }
    }
    
    private func swipeWeek(){
        withAnimation(.linear(duration: 0.2)) {
            self.weekSwipeAnim = 0
            
            if self.weekSwipeValue > 0 {
                if self.weekSwipeValue >= 15 {
                    // trigger switch to prev week
                    self.changeWeek(-1)
                }
            } else {
                if self.weekSwipeValue <= -15 {
                    self.changeWeek(1)
                }
            }
        }
    }
    
    private func swipeWeekAnimation(_ value: CGFloat){
        withAnimation(.linear(duration: 0.2)) {
            if value > 0 {
                // swipe to right
                if value < 15 {
                    self.weekSwipeAnim = value
                } else {
                    self.weekSwipeAnim = 15
                }
            } else {
                // swipe to left
                if value > -15 {
                    self.weekSwipeAnim = value
                } else {
                    self.weekSwipeAnim = -15
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .top) {
                ScrollView {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 110)
                        .frame(maxWidth: .infinity)
                        .padding(.top, geometry.safeAreaInsets.top)
                    
                    ZStack (alignment: .top) {
                        VStack (spacing: 0) {
                            ForEach(0...23, id: \.self){
                                CalendarBlankHour(hour: $0)
                            }
                        }
                        
                        CalendarDayView(selectedDate: $selectedDate)
                    }
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 110)
                        .frame(maxWidth: .infinity)
                        .padding(.top, geometry.safeAreaInsets.bottom)
                    
                }
                .frame(maxWidth: .infinity)
                
                ZStack {
                    VStack (spacing: 0) {
                        HStack (spacing: 0) {
                            Spacer()
                            
                            Text(self.selectedDate == nil ? "" : self.formatDate(self.selectedDate!, format: "eeee d MMMM y"))
                                .foregroundColor(config.theme.tabColorActive)
                                .font(.system(size: 16, weight: .bold))
                            
                            Spacer()
                            
                            Image(systemName: "plus")
                                .font(.system(size: 16))
                                .foregroundColor(config.theme.tabColorActive)
                                .padding(.trailing, 25)
                                .onTapGesture {
                                    newEventShowing.toggle()
                                }
                            
                        }.padding(.bottom, 15)
                        HStack {
                            ForEach(self.daysOfWeek, id: \.self){day in
                                VStack (alignment: .center) {
                                    Text(self.formatDate(day, format: "eeeee"))
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(config.theme.tabColorActive)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 25)
                        
                        HStack {
                            ForEach(self.daysOfWeek, id: \.self){day in
                                ZStack (alignment: .center){
                                    if day == self.selectedDate {
                                        Circle()
                                            .fill(config.theme.tabColorActive)
                                            .frame(width: 35, height: 35)
                                            .matchedGeometryEffect(id: "selectedCircle", in: animation)
                                    }
                                    
                                    Text(self.formatDate(day, format: "d"))
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(day == self.selectedDate ? config.theme.tabColor : config.theme.tabColorActive)
                                }
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    self.changeDate(day)
                                }
                            }
                        }
                        .padding(.top, 5)
                        .padding(.horizontal, 25)
                        .padding(.bottom, 15)
                    }
                    .padding(.top, geometry.safeAreaInsets.top)
                    .background(config.theme.tabColor)
                    .cornerRadius(50, corners: [.bottomLeft, .bottomRight])
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.weekSwipeValue = gesture.translation.width
                                self.swipeWeekAnimation(gesture.translation.width)
                            }
                            .onEnded { _ in
                                self.swipeWeek()
                            }
                    )
                    
                    HStack {
                        HStack (alignment: .center) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(config.theme.tabColor)
                        }
                        .frame(width: 40, height: 40)
                        .background(config.theme.tabBackground)
                        .cornerRadius(20)
                        .opacity(self.weekSwipeAnim > 0 ? self.weekSwipeAnim / 15 : 0)
                        .offset(x: self.weekSwipeAnim > 0 ? self.weekSwipeAnim : 0, y: 0)
                        .shadow(color: Color.black.opacity(0.1), radius: 25)
                        
                        Spacer()
                        
                        HStack (alignment: .center) {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(config.theme.tabColor)
                        }
                        .frame(width: 40, height: 40)
                        .background(config.theme.tabBackground)
                        .cornerRadius(20)
                        .opacity(self.weekSwipeAnim < 0 ? -self.weekSwipeAnim / 15 : 0)
                        .offset(x: self.weekSwipeAnim < 0 ? self.weekSwipeAnim : 0, y: 0)
                        .shadow(color: Color.black.opacity(0.1), radius: 25)
                    }
                    .allowsHitTesting(false)
                }
            }
            .background(config.theme.pageBackground)
            .onAppear {
                self.currentWeekStart = self.startOfWeek(Date())
                self.loadCalendar(Date())
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $newEventShowing){
                CalendarNewEventView()
            }
        }
    }
}
