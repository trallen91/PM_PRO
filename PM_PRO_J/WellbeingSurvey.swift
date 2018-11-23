//
//  WellbeingSurvey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
class WellbeingSurvey : Survey {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init () {
        super.init()
        self.Name = "Well-Being Survey"
    }
}
