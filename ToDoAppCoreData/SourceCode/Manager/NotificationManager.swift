//
//  NotificationManager.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 06/01/22.
//

import Foundation
import UserNotifications

/// This class is responsible for managing notification
class NotificationManager {
    
    // MARK: Properties
    static let instance: NotificationManager = NotificationManager()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    // MARK: Functions
    /// This function requests for notification permission
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
  
    /// This function schedule notification of the given ToDoEntity
    func scheduleNotification(todo: ToDoEntity) {
        let content = UNMutableNotificationContent()
        content.title = todo.title!
        content.subtitle = dateFormatter.string(from: todo.date!)
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .calendar, .timeZone],
            from: todo.date!)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,repeats: false)
        let request = UNNotificationRequest(
            identifier: todo.id?.uuidString ?? "1",
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    /// This function cancels and delivered or pending notification
    func cancelNotification(ids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ids)
    }
}
