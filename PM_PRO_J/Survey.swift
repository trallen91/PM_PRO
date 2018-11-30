//
//  Survey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation

class Survey : NSObject, NSCoding {

    var SurveyTypesPerQueue : NSNumber = 1 //How many of each survey we allow per queue, treat as all same for now
    
    var Name: NSString!
    var OpenDate: NSDate!
    var IsComplete: Bool!
        
    var DaysBetweenSurveys: NSNumber!
    var ExpirationDate: NSDate!
    
    //MARK: TO MAKE IT CONFORM TO NSCoding PROTOCOL
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.Name = aDecoder.decodeObject(forKey: "Name") as! NSString
        self.OpenDate = aDecoder.decodeObject(forKey: "OpenDate") as! NSDate
        self.IsComplete = aDecoder.decodeObject(forKey: "IsComplete") as! Bool
        self.DaysBetweenSurveys = aDecoder.decodeObject(forKey: "DaysBetweenSurveys") as! NSNumber
        self.ExpirationDate = aDecoder.decodeObject(forKey: "ExpirationDate") as! NSDate
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: "Name")
        aCoder.encode(OpenDate, forKey: "OpenDate")
        aCoder.encode(IsComplete, forKey: "IsComplete")
        aCoder.encode(DaysBetweenSurveys, forKey: "DaysBetweenSurveys")
        aCoder.encode(ExpirationDate, forKey: "ExpirationDate")
    }
    
    init(OpenDate : NSDate = NSDate()) {
        self.IsComplete = false
        self.OpenDate = OpenDate
        
        super.init()
    }
}
