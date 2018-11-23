//
//  Survey.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation

class Survey : NSObject, NSCoding {

    
    var Name: NSString!
    var OpenDate: NSDate!
    var IsComplete: Bool!
    
    //MARK: TO MAKE IT CONFORM TO NSCoding PROTOCOL
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.Name = aDecoder.decodeObject(forKey: "Name") as! NSString
        //self.OpenDate = aDecoder.decodeObject(forKey: "OpenDate") as! NSDate
        //self.IsComplete = aDecoder.decodeObject(forKey: "IsComplete") as? Bool
        
    }
    
    func encode(with aCoder: NSCoder) {
        //aCoder.encodeObject(ticker, forKey: "ticker")
        aCoder.encode(Name, forKey: "Name")
    }
    
    override init() {
        super.init()
    }
}
