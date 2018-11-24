//
//  StandardizedSurvey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import Foundation

class StandardizedSurvey : Survey {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init (OpenDate : NSDate = NSDate()) {
        super.init()
        self.Name = "Standardized Survey"
        //self.SurveyInterval.day = 14
        
        
        self.DaysBetweenSurveys = 14
        
        let daysValid = (self.DaysBetweenSurveys as! Int) * (self.SurveyTypesPerQueue as! Int) //Becomes invalid when queue has too many of this type
        
        self.ExpirationDate = Calendar.current.date(byAdding: .day, value: daysValid, to: self.OpenDate! as Date) as! NSDate
    }
}
