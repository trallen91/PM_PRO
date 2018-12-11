//
//  WellbeingSurvey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
class WellbeingSurvey : Survey {
    var surveyTimeMgr : SurveyTimesManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (OpenDate : NSDate = NSDate()) {
        super.init()
        surveyTimeMgr = SurveyTimesManager()
        self.Name = "Well-Being Survey"
        let now = Date() // today
        let wbSurveyDate = surveyTimeMgr.wellBeingTime as DateComponents
        
        //Set Expiration Date as the next time this survey gets created
        self.ExpirationDate = Calendar.current.nextDate(after: now,
                                                        matching: wbSurveyDate,
                                                        matchingPolicy:.nextTime) as! NSDate
    }
}
