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
    var name : NSString = "Standardized Survey"
    
    override init () {
        super.init()
        self.Name = name
    }
}
