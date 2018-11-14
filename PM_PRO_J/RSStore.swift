//
//  RSStore.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/13/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchSuiteAppFramework
import ResearchSuiteExtensions
import ResearchSuiteTaskBuilder
import LS2SDK

class RSStore: NSObject, RSTBStateHelper {
    
    let store = RSKeychainCredentialsStore(namespace: "appStore")
    
    func objectInState(forKey: String) -> AnyObject? {
        switch forKey {
        case "ls2Manager":
            return AppDelegate.appDelegate.ls2Manager
        default:
            return nil
        }
    }
    
    
    func valueInState(forKey: String) -> NSSecureCoding? {
        return self.get(key: forKey)
    }
    
    func setValueInState(value: NSSecureCoding?, forKey: String) {
        self.set(value: value, key: forKey)
    }
    
    func set(value: NSSecureCoding?, key: String) {
        store.setValueInState(value: value, forKey: key)
    }
    func get(key: String) -> NSSecureCoding? {
        return store.valueInState(forKey: key)
    }
}
