//
//  DoneToDosView.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 04/01/22.
//

import SwiftUI

/// List of all done todos, also possible to deleted them all from here.
struct DoneToDosView: View {
    
    // MARK: Properties
    @EnvironmentObject private var todoViewMode: ToDoViewModel
    @State private var showingAlert: Bool = false
    @State private var deleteAll: Bool = false
    
    /// This function returns all done todos
    private var allDoneTodos: [ToDoEntity] {
        todoViewMode.todos.filter { todo in
            todo.done
        }
    }
    
    // MARK: Body
    var body: some View {
        VStack {
            HStack {
                Text("All Done")
                Spacer()
                Image(systemName: "trash")
                    .onTapGesture {
                        showingAlert = true
                    }
                    .alert("Do you want to delete all done todos?", isPresented: $showingAlert) {
                        Button("Yes", role: .destructive) {
                            todoViewMode.deleteAllDone()
                        }
                    }
            }
            .font(.system(size: 24, weight: .medium))
            .padding(16)
            ScrollView {
                ForEach(allDoneTodos){ todo in
                    Text("\(todo.title!)")
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
        }
    }
}

// MARK: Previews
struct DoneToDosView_Previews: PreviewProvider {
    static var previews: some View {
        DoneToDosView()
    }
}
