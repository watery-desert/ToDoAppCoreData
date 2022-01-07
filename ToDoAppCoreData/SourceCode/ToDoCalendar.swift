//
//  ToDoCalendar.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 06/01/22.
//

import SwiftUI

/// Calendar view of the app
///
/// This is the left view, where top portion is horizontal scrollable calendar and
/// bottom portion is vertical scrollable list of todos of that selected date
struct ToDoCalendar: View {
    
    // MARK: Properties
    let canvasColor: Color
    
    // MARK: Body
    var body: some View {
        VStack(spacing: 0.0) {
            RowCalendar()
            ToDoList(tileBackground: canvasColor)
        }
    }
}

// MARK: Previews
struct ToDoCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ToDoCalendar(canvasColor: .red)
    }
}
