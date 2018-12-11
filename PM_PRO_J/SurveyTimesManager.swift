//
//  NotificationManager.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 12/10/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation


class SurveyTimesManager {
    let notificationMgr: NotificationsManager!
    let store: RSStore!
    
    public init() {
        self.store = RSStore()
        self.notificationMgr = NotificationsManager()
    }
    
    var _wellBeingTime: NSDateComponents? = nil
    var wellBeingTime: NSDateComponents {
        get {
            var notifDate = NSDateComponents()
            
            let hour = self.store.valueInState(forKey: "wellBeingNotificationHour") as! Int
            let minutes = self.store.valueInState(forKey: "wellBeingNotificationMinutes") as! Int
            let weekday = self.store.valueInState(forKey: "wellBeingNotificationDayofWeek") as! Int
            
            notifDate.hour = hour
            notifDate.minute = minutes
            notifDate.weekday = weekday
            
            self._wellBeingTime = notifDate
            
            return self._wellBeingTime ?? NSDateComponents()
        }
        set (newValue) {
            // cancel old notifications
            let oldValue =  self._wellBeingTime
            if (oldValue != nil) {
                self.notificationMgr.cancelNotification(fireDate: oldValue!)
            }
            
            //create new
            self._wellBeingTime = newValue
            
            let hour = newValue.hour
            let minutes = newValue.minute
            let weekday = newValue.weekday
            
            //store in state
            self.store.setValueInState(value: hour as! NSNumber, forKey: "wellBeingNotificationHour")
            self.store.setValueInState(value: minutes as! NSNumber, forKey: "wellBeingNotificationMinutes")
            self.store.setValueInState(value: weekday as! NSNumber, forKey: "wellBeingNotificationDayofWeek")
            
            //create notification
            var fireDate = NSDateComponents()
            fireDate.hour = hour
            fireDate.minute = minutes
            fireDate.weekday = weekday
            let notificationBody = "It's time to take your Weekly Well-Being Survey!"
            self.notificationMgr.createNotification(fireDate: fireDate, notificationBody: notificationBody)
        }
    }
    
    var _sideEffectTime: NSDateComponents? = nil
    var sideEffectTime: NSDateComponents {
        get {
            var notifDate = NSDateComponents()
            
            let hour = self.store.valueInState(forKey: "sideEffectNotificationHour") as! Int
            let minutes = self.store.valueInState(forKey: "sideEffectNotificationMinutes") as! Int

            
            notifDate.hour = hour
            notifDate.minute = minutes
            
            self._sideEffectTime = notifDate
            
            return self._sideEffectTime ?? NSDateComponents()
        }
        set (newValue) {
            // cancel old notifications
            let oldValue =  self._sideEffectTime
            if (oldValue != nil) {
                self.notificationMgr.cancelNotification(fireDate: oldValue!)
            }
            
            //create new
            self._sideEffectTime = newValue
            
            let hour = newValue.hour
            let minutes = newValue.minute
            
            //store in state
            self.store.setValueInState(value: hour as! NSNumber, forKey: "sideEffectNotificationHour")
            self.store.setValueInState(value: minutes as! NSNumber, forKey: "sideEffectNotificationMinutes")

            
            //create notification
            var fireDate = NSDateComponents()
            fireDate.hour = hour
            fireDate.minute = minutes
            
            let notificationBody = "It's time to take your Daily Side Effects Survey"
            self.notificationMgr.createNotification(fireDate: fireDate, notificationBody: notificationBody)
        }
    }
    

}
