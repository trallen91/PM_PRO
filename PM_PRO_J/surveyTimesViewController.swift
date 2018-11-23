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
    
    func setNotification(resultAnswer: DateComponents, surveyName: String) {
        
        var userCalendar = Calendar.current
        userCalendar.timeZone = TimeZone(abbreviation: "EDT")!
        
        var fireDate = NSDateComponents()
        
        let hour = resultAnswer.hour
        let minutes = resultAnswer.minute
        let weekday = resultAnswer.weekday
        
        fireDate.hour = hour!
        fireDate.minute = minutes!
        
        //TAKE CARE OF STORING VALUE IN STATE MACHINE
        if (surveyName == "Side-Effects") {
            
            self.store.setValueInState(value: String(describing:hour!) as NSSecureCoding, forKey: "sideEffectNotificationHour")
            self.store.setValueInState(value: String(describing:minutes!) as NSSecureCoding, forKey: "sideEffectNotificationMinutes")
        }
        
        if (surveyName == "Well-Being") {
            fireDate.weekday = weekday!
            
            self.store.setValueInState(value: String(describing:hour!) as NSSecureCoding, forKey: "wellBeingNotificationHour")
            self.store.setValueInState(value: String(describing:minutes!) as NSSecureCoding, forKey: "wellBeingNotificationMinutes")
            self.store.setValueInState(value: String(describing:weekday!) as NSSecureCoding?, forKey: "wellBeingNotificationDayofWeek")
        }
        

        
        let notificationHeaderTitle = "Precision Medicine Study"
        let notificationBody = "It's time to complete the \(surveyName) Survey"
        
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
        
        
        //initialize empty survey queue
//        let initialSurveyQueue = SurveyQueue()
//        initialSurveyQueue.surveys = []
//        self.store.setValueInState(value: initialSurveyQueue as! NSSecureCoding, forKey: "surveyQueue")
        
//        let updateQueueDate = userCalendar.date(from: fireDate as DateComponents)!
//        let timer = Timer(fireAt: updateQueueDate, interval: 0, target: self, selector: #selector(addToSurveyQueue), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer, forMode: .common)
        
        
    }
    
//    @objc func addToSurveyQueue(surveyTime: NSDateComponents, surveyName: String){
//        //GET DATE NOW
//        //CREATE AN INSTANCE OF SURVEY OBJECT WITH SURVEY NAME AND CURRENT DATE
//        //UPDATE THE SURVEY QUEUE CLASS WITH THIS NEW ONE
//        
//        //GET CURRENT SURVEY QUEUE FROM STATE MACHINE
//        // ADD THIS NEW SURVEY TO QUEUE
////        self.store.setValueInState(value: outstandingSurveys as NSSecureCoding, forKey: "outStandingSurveys")
//        
//        
//    }
}

extension SurveyTimesViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
        
        var sideEffectSurveyDate = DateComponents()
        var wellBeingSurveyDate = DateComponents()
        var standardizedSurveyDate = DateComponents()
        
        let taskResultS = taskViewController.result.results
        for stepResults in taskResultS! as! [ORKStepResult]
        {
            for result in stepResults.results!
            {
                if (result.identifier == "wbTime") {
                    let wbTimeSurveyResult = result as! ORKTimeOfDayQuestionResult
                    let wbTime = wbTimeSurveyResult.answer as! DateComponents
                    
                    wellBeingSurveyDate.hour = wbTime.hour
                    wellBeingSurveyDate.minute = wbTime.minute
                }
                if (result.identifier == "wbWeekday") {
                    let wbDaySurveyResult = result as! ORKChoiceQuestionResult
                    let wbDayArr = wbDaySurveyResult.answer as! NSArray
                    
                    let wbDay = wbDayArr[0] as! NSNumber
                    
                    wellBeingSurveyDate.weekday = wbDay.intValue
                    
                    self.setNotification(resultAnswer: wellBeingSurveyDate, surveyName: "Well-Being")
                }
                if (result.identifier == "sideEffectsSurveyTime") {
                    let sideFxTimeSurveyResult = result as! ORKTimeOfDayQuestionResult
                    let sideFxTime = sideFxTimeSurveyResult.answer as! DateComponents
                    
                    sideEffectSurveyDate.hour = sideFxTime.hour
                    sideEffectSurveyDate.minute = sideFxTime.minute
                    
                    self.setNotification(resultAnswer: sideEffectSurveyDate, surveyName: "Side-Effects")
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
