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

class SurveyTimesViewController: UIViewController {
    var store: RSStore!
    var sqMgr: SurveyQueueManager!
    var surveyTimeMgr: SurveyTimesManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Set Survey Times"
        self.store = RSStore()
        self.sqMgr = SurveyQueueManager()
        self.surveyTimeMgr = SurveyTimesManager()
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
    
    
}

extension SurveyTimesViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
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
                        
                        self.surveyTimeMgr.wellBeingTime = wellBeingSurveyDate as NSDateComponents
                    }
                    if (result.identifier == "ssTime" ) {
                        let ssTimeSurveyResult = result as! ORKTimeOfDayQuestionResult
                        let ssTime = ssTimeSurveyResult.answer as! DateComponents
                        
                        standardizedSurveyDate.hour = ssTime.hour
                        standardizedSurveyDate.minute = ssTime.minute
                    }
                    if (result.identifier == "ssWeekday") {
                        let ssDaySurveyResult = result as! ORKChoiceQuestionResult
                        let ssDayArr = ssDaySurveyResult.answer as! NSArray
                        
                        let ssDay = ssDayArr[0] as! NSNumber
                        
                        standardizedSurveyDate.weekday = ssDay.intValue
                        
                        self.surveyTimeMgr.standardizedTime = standardizedSurveyDate as NSDateComponents
                    }
                    if (result.identifier == "sideEffectsSurveyTime") {
                        let sideFxTimeSurveyResult = result as! ORKTimeOfDayQuestionResult
                        let sideFxTime = sideFxTimeSurveyResult.answer as! DateComponents
                        
                        sideEffectSurveyDate.hour = sideFxTime.hour
                        sideEffectSurveyDate.minute = sideFxTime.minute
                        
                        self.surveyTimeMgr.sideEffectTime = sideEffectSurveyDate as NSDateComponents
                    }
                    
                    print(result)
                    
                }
            }
            
            self.sqMgr.initializeSurveyQueue() // create an initial survey that they will see the first time they hit the home screen

            
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
