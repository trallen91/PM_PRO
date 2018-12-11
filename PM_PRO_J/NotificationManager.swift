//
//  NotificationManager.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 12/10/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class SurveyNotificationManager {
    
    let store: RSStore!
    
    public init() {
        self.store = RSStore()
    }
    
    var _wbNotification: NSDateComponents? = nil
    var wbNotification: NSDateComponents {
        get {
            var notifDate = NSDateComponents()
            
            let hour = self.store.valueInState(forKey: "wellBeingNotificationHour") as! Int
            let minutes = self.store.valueInState(forKey: "wellBeingNotificationMinutes") as! Int
            let weekday = self.store.valueInState(forKey: "wellBeingNotificationDayofWeek") as! Int
            
            notifDate.hour = hour
            notifDate.minute = minutes
            notifDate.weekday = weekday
            
            self._wbNotification = notifDate
            
            return self._wbNotification ?? NSDateComponents()
        }
        set (newValue) {
            // cancel old notifications
            let oldValue =  self._wbNotification
            if (oldValue != nil) {
                cancelNotification(fireDate: oldValue!)
            }
            
            //create new
            self._wbNotification = newValue
            
            let hour = newValue.hour
            let minutes = newValue.minute
            let weekday = newValue.weekday
            
            //store in state
            self.store.setValueInState(value: String(describing:hour) as NSSecureCoding, forKey: "wellBeingNotificationHour")
            self.store.setValueInState(value: String(describing:minutes) as NSSecureCoding, forKey: "wellBeingNotificationMinutes")
            self.store.setValueInState(value: String(describing:weekday) as NSSecureCoding?, forKey: "wellBeingNotificationDayofWeek")
            
            //create notification
            var fireDate = NSDateComponents()
            fireDate.hour = hour
            fireDate.minute = minutes
            fireDate.weekday = weekday
            let notificationBody = "It's time to take your Weekly Well-Being Survey!"
            createNotification(fireDate: fireDate, notificationBody: notificationBody)
        }
    }
    
    var _seNotification: NSDateComponents? = nil
    var seNotification: NSDateComponents {
        get {
            var notifDate = NSDateComponents()
            
            let hour = self.store.valueInState(forKey: "sideEffectNotificationHour") as! Int
            let minutes = self.store.valueInState(forKey: "sideEffectNotificationMinutes") as! Int

            
            notifDate.hour = hour
            notifDate.minute = minutes
            
            self._seNotification = notifDate
            
            return self._seNotification ?? NSDateComponents()
        }
        set (newValue) {
            // cancel old notifications
            let oldValue =  self._seNotification
            if (oldValue != nil) {
                cancelNotification(fireDate: oldValue!)
            }
            
            //create new
            self._seNotification = newValue
            
            let hour = newValue.hour
            let minutes = newValue.minute
            
            //store in state
            self.store.setValueInState(value: String(describing:hour) as NSSecureCoding, forKey: "sideEffectNotificationHour")
            self.store.setValueInState(value: String(describing:minutes) as NSSecureCoding, forKey: "sideEffectNotificationMinutes")

            
            //create notification
            var fireDate = NSDateComponents()
            fireDate.hour = hour
            fireDate.minute = minutes
            
            let notificationBody = "It's time to take your Daily Side Effects Survey"
            createNotification(fireDate: fireDate, notificationBody: notificationBody)
        }
    }
    
    func createNotification(fireDate: NSDateComponents, notificationBody: String){
        var userCalendar = Calendar.current
        userCalendar.timeZone = TimeZone(abbreviation: "EDT")!
        
        let notificationHeaderTitle = "Precision Medicine Study"
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = notificationHeaderTitle
            content.body = notificationBody
            content.sound = UNNotificationSound.default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate as DateComponents,
                                                        repeats: true)
            
            let identifier = "UYLLocalNotification"
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content, trigger: trigger)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.center.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                }
            })
            
        } else {
            // Fallback on earlier versions
            
            let dateToday = Date()
            let day = userCalendar.component(.day, from: dateToday)
            let month = userCalendar.component(.month, from: dateToday)
            let year = userCalendar.component(.year, from: dateToday)
            
            fireDate.day = day
            fireDate.month = month
            fireDate.year = year
            
            let fireDateLocal = userCalendar.date(from:fireDate as DateComponents)
            
            let localNotification = UILocalNotification()
            localNotification.fireDate = fireDateLocal
            localNotification.alertTitle = notificationHeaderTitle
            localNotification.alertBody = notificationBody
            localNotification.timeZone = TimeZone(abbreviation: "EDT")!
            //set the notification
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    func cancelNotification(fireDate: NSDateComponents) {
//        let canceledNotifDate = fireDate as! DateComponents
//
//        var scheduledNotifications:NSArray? = UIApplication.shared.scheduledLocalNotifications as! NSArray
//
//        for scheduledEvent in scheduledNotifications! {
//            var notification = scheduledEvent as! UILocalNotification
//
//            if notification.fireDate == canceledNotifDate {
//                UIApplication.shared.cancelLocalNotification(notification)
//                break;
//            }
//        }
        
    }
}
