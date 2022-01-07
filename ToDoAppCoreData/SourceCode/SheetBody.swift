//
//  MenuBody.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 02/01/22.
//

import SwiftUI

/// This view has TextField to input todo, choose date and catagory and finally adding to core data
struct SheetBody: View {
    
    // MARK: Properties
    @EnvironmentObject private var todoViewModel: ToDoViewModel
    
    @State private var text: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedIcon: String?
    private let notificationManager = NotificationManager.instance
    private let color: Color = Color(hex: 0xC0C0C0)
    
    private let thisYear = Calendar.current.component(.year, from: Date())
    private var lastDate:  Date  {
        Calendar.current.date(from: DateComponents( year: self.thisYear + 1 )) ?? Date()
    }
    
    // MARK: Body
    var body: some View {
        VStack (alignment: .leading) {
            TextField("", text: $text)
                .padding()
                .background(Color(hex: 0x383838))
                .cornerRadius(16)
            Group {
                SectionHeading(text: "Pick date & time")
                DatePicker("Pick Date & Time", selection: $selectedDate, in: Date()...lastDate)
                    .preferredColorScheme(.dark)
                    .labelsHidden()
                SectionHeading(text: "Catagory")
                HStack {
                    CatagoryTile(iconName: "laptopcomputer", selected: $selectedIcon )
                    Spacer()
                    CatagoryTile(iconName:"cart" , selected: $selectedIcon)
                    Spacer()
                    CatagoryTile(iconName: "bolt" , selected: $selectedIcon)
                    Spacer()
                    CatagoryTile(iconName: "message" , selected: $selectedIcon)
                    Spacer()
                    CatagoryTile(iconName: "book.closed", selected: $selectedIcon)
                }
            }
            .foregroundColor(color)
            BouncyButton(title: "Add", color: Color(hex: 0x50996D), action: onTapAdd)
                .padding(.top, 36)
            
        }
        .onAppear {
            notificationManager.requestAuthorization()
        }
    }
    
    // MARK: Functions
    /// Adds todo to core data
    private func onTapAdd() {
        guard !text.isEmpty, let selectedIcon = selectedIcon else { return }
        let todo = todoViewModel.addToDo(title: self.text, date: selectedDate, catagory: selectedIcon)
        notificationManager.scheduleNotification(todo: todo)
        text = ""
        selectedDate = Date()
        self.selectedIcon = nil
    }
}

// MARK: Previews
struct SheetBody_Previews: PreviewProvider {
    static var previews: some View {
        SheetBody()
            .frame(maxHeight: .infinity)
            .background(.black)
    }
}

// MARK: Subviews
/// Heading title for each section
struct SectionHeading: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .bold))
            .padding( .bottom, 8)
            .padding(.top, 24)
    }
}

/// Catagory Icon Button
struct CatagoryTile: View {
    let iconName: String
    @Binding var selected: String?
    private let frameSize: CGFloat = 54
    var body: some View {
        Group {
            if selected == iconName {
                Image(systemName: iconName)
                    .frame(width: frameSize, height: frameSize)
                    .background(Color(hex: 0x3C3C3C))
            } else  {
                Image(systemName: iconName)
                    .frame(width: frameSize, height: frameSize)
            }
        }
        .clipShape(Circle())
        .font(.system(size: 26))
        .onTapGesture {
            selected = iconName
        }
    }
}
