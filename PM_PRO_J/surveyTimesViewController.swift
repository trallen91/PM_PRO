//
//  surveyTimesViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/21/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit
import UserNotifications

class SurveyTimesViewController: UIViewController {
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Set Survey Times"
        self.store = RSStore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setSurveyTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: SetSurveyTimeTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func setNotification(resultAnswer: DateComponents) {
        
        var userCalendar = Calendar.current
        userCalendar.timeZone = TimeZone(abbreviation: "EDT")!
        
        var fireDate = NSDateComponents()
        
        let hour = resultAnswer.hour
        let minutes = resultAnswer.minute
        
        fireDate.hour = hour!
        fireDate.minute = minutes!
        
        self.store.setValueInState(value: String(describing:hour!) as NSSecureCoding, forKey: "notificationHour")
        self.store.setValueInState(value: String(describing:minutes!) as NSSecureCoding, forKey: "notificationMinutes")
        
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Precision Medicine Study"
            content.body = "It's time to complete your ______ Survey"
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
            localNotification.alertTitle = "Precision Medicine Study"
            localNotification.alertBody = "It's time to complete your ______ Survey"
            localNotification.timeZone = TimeZone(abbreviation: "EDT")!
            //set the notification
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
        
        
    }
    
}

extension SurveyTimesViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
        
        let taskResultS = taskViewController.result.results
        
        for stepResults in taskResultS! as! [ORKStepResult]
        {
            for result in stepResults.results!
            {
               //first try to set the time for the daily notification survey
                if (result.identifier == "sideEffectsSurveyTime") {
                    let dailySurveyResult = result as! ORKTimeOfDayQuestionResult
                    let dailySurveyTime = dailySurveyResult.answer as! DateComponents
                    
                    self.setNotification(resultAnswer: dailySurveyTime)
                }
                print(result)
                
            }
        }
        
        
        
        
        
        if reason == .completed {
            self.store.set(value: true as NSSecureCoding, key: "hasSetSurvey")
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyboard.instantiateInitialViewController()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.transition(toRootViewController: vc!, animated: true)
            }
        }
    }
    
}
