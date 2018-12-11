//
//  SurveyQueueManager.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 12/10/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation

class SurveyQueueManager {
    let store: RSStore!
    var surveyQueue: [Survey]!
    
    public init() {
        self.store = RSStore()
    }
    
    var _surveyQ: [Survey]? = nil
    var surveyQ: [Survey] {
        get {
            if (self.store.valueInState(forKey: "surveyQueue") != nil) {
                self._surveyQ = self.store.valueInState(forKey: "surveyQueue") as! [Survey]
            }
            return self._surveyQ ?? []
        }
        set(newValue) {
            let oldValue = self._surveyQ
            self._surveyQ = newValue
            self.store.setValueInState(value: self._surveyQ as! NSSecureCoding, forKey: "surveyQueue")
        }
    }
    
    func initializeSurveyQueue() {
        print("Initializing Survey Queue...")
        
        var initialSurveyQueue : [Survey] = []
        
        let initialStandardized = StandardizedSurvey()
        print(initialStandardized.Name)
        initialSurveyQueue.append(initialStandardized)
        
        let initialWB = WellbeingSurvey()
        print(initialWB.Name)
        initialSurveyQueue.append(initialWB)
        
        let initialSE = SideEffectSurvey()
        print(initialSE.Name)
        initialSurveyQueue.append(initialSE)
        
        self.surveyQ = initialSurveyQueue
    }
    
    func getOutstandingSurveys() -> [Survey] {

        //OUTSTANDING SURVEYS
        var outstandingSurveys: [Survey] = []

        for survey in self.surveyQ {
            if !(survey.IsComplete) {
                outstandingSurveys.append(survey)
            }
        }

        return outstandingSurveys
    }

    
    func updateSurveyQueue() {
        //surveyQueue =  self.store.valueInState(forKey: "surveyQueue") as! [Survey]
        var updatedSurveyQ : [Survey] = []
        
        // GET CURRENT DATETIME
        let currentDate = NSDate()
        
        for survey in self.surveyQ {
            let surveyType = survey.Name
            if (currentDate.laterDate(survey.ExpirationDate as Date) == currentDate as Date) {//means survey is expired...this shouldn't be the only way to add new surveys to queue, but can revisit
                var newSurvey : Survey!
                let newSurveyOpenDate = Calendar.current.date(byAdding: .day, value: survey.DaysBetweenSurveys as! Int, to: survey.OpenDate! as Date) as! NSDate
                
                if (surveyType == "Standardized Survey") { //SHOULD THIS BE TYPE CHECKING?
                    newSurvey = StandardizedSurvey(OpenDate: newSurveyOpenDate)
                }
                else if (surveyType == "Well-Being Survey") {
                    newSurvey = WellbeingSurvey(OpenDate: newSurveyOpenDate)
                }
                else if (surveyType == "Side-Effects Survey") {
                    newSurvey = SideEffectSurvey(OpenDate: newSurveyOpenDate)
                }
                
                updatedSurveyQ.append(newSurvey)
            }
            else {
                updatedSurveyQ.append(survey)
            }
        }
        
        
        self.surveyQ = updatedSurveyQ
        
    }
}
