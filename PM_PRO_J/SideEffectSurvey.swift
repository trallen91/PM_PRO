//
//  SideEffectSurvey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import Foundation

class SideEffectSurvey : Survey {
    var surveyTimeMgr : SurveyTimesManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (OpenDate : NSDate = NSDate()) {
        super.init()
        surveyTimeMgr = SurveyTimesManager()
        
        self.Name = "Side-Effects Survey"
        //self.DaysBetweenSurveys = 1
        
        //let daysValid = (self.DaysBetweenSurveys as! Int) * (self.SurveyTypesPerQueue as! Int) //Becomes invalid when queue has too many of this type
        
        //self.ExpirationDate = Calendar.current.date(byAdding: .day, value: daysValid, to: self.OpenDate! as Date) as! NSDate
        
        let now = Date() // today
        let seSurveyDate = surveyTimeMgr.sideEffectTime as DateComponents
        
        //Set Expiration Date as the next time this survey gets created
        self.ExpirationDate = Calendar.current.nextDate(after: now,
                                                     matching: seSurveyDate,
                                                     matchingPolicy:.nextTime) as! NSDate
    }
}
