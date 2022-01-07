//
//  CalendarView.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 02/01/22.
//

import SwiftUI

/// Top horozontal scrollable dates
struct RowCalendar: View {
    
    // MARK: Properties
    @EnvironmentObject private var todoViewModel: ToDoViewModel
    
    private var endDate: Date  {
        var dayComponent = DateComponents()
        dayComponent.day = 7
        let resultDate = Calendar.current.date(byAdding: dayComponent, to: todoViewModel.firstDate)
        return resultDate!
    }
    
    private var dateDifference: Int {
        let resultDate =
        Calendar.current.dateComponents([.day], from: todoViewModel.firstDate, to: endDate).day ?? 0
        return resultDate + 1
    }
    
    
    // MARK: Body
    var body: some View {
        ZStack {
            Color(hex: 0xFFF9C7)
                .ignoresSafeArea( edges: .top)
            VStack {
                HStack {
                    Text("TODO")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                    Image("baby")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fill)
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(0..<dateDifference) { index in
                            
                            let date: Date = dateFromIndex(index)
                            let formattedDate: String = formattedDate(date)
                            let formattedDay: String = formattedDay(date)
                            let isSelected: Bool = todoViewModel
                                .isEqualDate(date, todoViewModel.selectedDate)
                            
                            Group {
                                if isSelected {
                                    DateTile(index: index, day: formattedDay, date: formattedDate, onTapTile:{})
                                        .background(Color.accentColor)
                                        .cornerRadius(10)
                                    
                                } else {
                                    DateTile(index: index, day: formattedDay, date: formattedDate) {
                                        
                                        todoViewModel.updateCalendarDate(date)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .frame(maxWidth:.infinity)
        .frame(height: 160)
    }
    
    /// Get the date of the selected index in the list
    private func dateFromIndex(_ index: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = index
        return Calendar.current.date(byAdding: dayComponent, to: todoViewModel.firstDate)!
    }
    
    /// Get the formatted Date from a given Date
    private func formattedDate(_ date: Date) -> String  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    /// Get the formatted Date from a given Date
    private func formattedDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

// MARK: Previews
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        RowCalendar()
    }
}

typealias OnTap = () -> Void

/// This the date tile in the top calendar row
struct DateTile: View {
    let index: Int
    let day: String
    let date: String
    let onTapTile: OnTap
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 14, weight: .medium))
            Text(date)
                .font(.system(size: 20, weight: .bold))
            
        }
        .frame(width: 52, height: 68)
        .onTapGesture(perform: onTapTile)
        
    }
}
