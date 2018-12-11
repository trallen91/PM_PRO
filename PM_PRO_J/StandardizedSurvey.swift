//
//  StandardizedSurvey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import Foundation

class StandardizedSurvey : Survey {
    var surveyTimeMgr : SurveyTimesManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (OpenDate : NSDate = NSDate()) {
        super.init()
        
        surveyTimeMgr = SurveyTimesManager()
        self.Name = "Standardized Survey"

        let now = Date() // today
        let standardSurveyDate = surveyTimeMgr.standardizedTime as DateComponents
        
        //Set Expiration Date as the next time this survey gets created
        self.ExpirationDate = Calendar.current.nextDate(after: now,
                                                        matching: standardSurveyDate,
                                                        matchingPolicy:.nextTime) as! NSDate
    }
}
