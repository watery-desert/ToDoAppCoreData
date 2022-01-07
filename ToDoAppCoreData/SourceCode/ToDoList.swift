//
//  ToDoListView.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 04/01/22.
//

import SwiftUI

/// List of all todos on the selected date in calendar
struct ToDoList: View {
    
    // MARK: Properties
    @EnvironmentObject var todoViewModel: ToDoViewModel
    let tileBackground: Color
    
    private let today = Date()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    // MARK: Body
    var body: some View {
        if todoViewModel.seletedDateTodos.isEmpty {
            
            VStack {
                Spacer()
                Image("relaxation")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 320)
                Spacer()
            }
        }  else  {
            
            ScrollView {
                VStack(spacing: 0.0) {
                    ForEach (todoViewModel.seletedDateTodos) { todo in
                        let frameSize: CGFloat = 40
                        HStack(spacing: 0.0) {
                            Image(systemName: todo.catagory ?? "square.and.arrow.up.trianglebadge.exclamationmark")
                                .font(.system(size: 18))
                                .frame(width: frameSize, height:  frameSize)
                                .padding(.horizontal, 16)
                                .background(todo.done ? Color.black.opacity(0.1) : Color.accentColor)
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 4.0) {
                                
                                Text(todo.title ?? "NO NAME FOUND")
                                    .strikethrough(todo.done ? true: false, color: Color.red)
                                    .font(.system(size: 18, weight: .medium))
                                
                                HStack {
                                    Text(dateFormatter.string(from: todo.date ?? today))
                                        .strikethrough(todo.done ? true: false, color: Color.red)
                                    if todo.willNotify {
                                        Image(systemName: "bell")
                                    }
                                }
                                .font(.system(size: 14))
                            }
                            .padding(.vertical, 8)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(tileBackground)
                        .onTapGesture {onTapTile(todo)}
                        .padding(.vertical, 8)
                        
                        
                        
                    }
                }
            }
        }
    }
    
    // MARK: Functions
    /// function to hold the on tap tile closure logic
    private func onTapTile(_ todo: ToDoEntity) {
        if(todo.willNotify) {
            todoViewModel.toggleDone(entity: todo)
            NotificationManager.instance.cancelNotification(ids: [todo.id?.uuidString ?? ""])
        } else {
            todoViewModel.toggleDone(entity: todo)
        }
    }
}

// MARK: Previews
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList(tileBackground: Color.red)
    }
}
