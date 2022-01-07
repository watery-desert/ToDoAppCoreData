//
//  ToDoViewModel.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 02/01/22.
//

//import Foundation
import CoreData


class ToDoViewModel: ObservableObject {
    
    // MARK: Properties
    static let instance = ToDoViewModel()
    private let container: NSPersistentContainer
    @Published var todos: [ToDoEntity] = []
    @Published var selectedDate = Date()
    @Published var seletedDateTodos: [ToDoEntity] = []
    var firstDate: Date {
        let today = Date()
        if todos.isEmpty {
            return today
        } else if (todos.first?.date)! > today {
            return today
        } else {
            return (todos.first?.date)!
        }
    }
   
    // MARK: init
    private init() {
        container = NSPersistentContainer(name: "ToDoContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading todo: \(error)")
            }
        }
        fetchTodos()
        updateCalendarDate(selectedDate)
    }
    
    // MARK: Functions
    private func fetchTodos() {
        let request = NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
        
        do {
            
         todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    
    /// Add new ToDo to core data
    ///
    /// This function a new ToToEntitiy to core data and returns
    /// that ToDoEntity
    /// 
    /// - Parameters:
    ///   - title: Title of the todo.
    ///   - date: ``Date`` for the todo
    ///   - catagory: SF symbol as catagory
    ///
    /// - Returns: Returns ``ToDoEntity``.
    func addToDo(title: String, date: Date, catagory: String) -> ToDoEntity {
        let newDoTo = ToDoEntity(context: container.viewContext)
        newDoTo.id = UUID()
        newDoTo.title = title
        newDoTo.date = date
        newDoTo.catagory = catagory
        newDoTo.done = false
        newDoTo.willNotify = true
        saveData()
        return newDoTo
    }
    
    /// This function toggle done
    ///
    /// This function toggle done and set ``willNotify`` to false
    ///
    /// - Parameters:
    ///   - entity: take ``ToDoEntity`` instance
    ///
    /// - Returns: Returns ``Void``.
    func toggleDone(entity: ToDoEntity) {
        entity.willNotify = false
        entity.done = !entity.done
        saveData()
    }
    
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchTodos()
            updateCalendarDate(selectedDate)
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    

    /// Compare if two dates are equal
    ///
    /// This function helps to find out two given dates are equals. It returns true if
    /// they are equal, false if they are not equal
    ///
    /// - Parameters:
    ///   - firstDate: takes first date of type ``Date``
    ///   - secondDate: takes second date of type ``Date``
    /// - Returns: Returns ``Bool``.
     func isEqualDate (_ firstDate: Date, _ secondDate: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        formatter.timeZone = .none
        
        
        return formatter.string(from: firstDate)
            == formatter.string(from: secondDate)
    }
    
  
    /// Updates the selected date
    ///
    ///
    /// - Parameters:
    ///   - date: takes the date to update ``selectedDate`` of type ``Date``
    ///
    /// - Returns: Returns ``Void``.
    func updateCalendarDate(_ date: Date) {
        selectedDate = date
        var filteredList = todos.filter { todo in
            isEqualDate(selectedDate, todo.date!)
        }
        
        filteredList.sort{
            $0.date! < $1.date!
        }
    
        seletedDateTodos.removeAll()
        seletedDateTodos.append(contentsOf: filteredList)
    }
    
    /// Deletes all done todos
    /// - Returns: Returns ``Void``
    func deleteAllDone() {
       let allDoneTodos = todos.filter { todo in
            todo.done
        }
        allDoneTodos.forEach { todo in
            container.viewContext.delete(todo)
        }
        saveData()
    }
    
}
