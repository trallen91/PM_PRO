//
//  Store.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//


import UIKit
//import OhmageOMHSDK
import ResearchSuiteTaskBuilder
//import ResearchSuiteAppFramework
//import AncileStudyServerClient
import CoreLocation
//import MobileCacheSDK

open class Store: NSObject  {
    
//    static public let kConsentDocURL = "ancile_study_consent_doc_URL"
//    static public let kLastSurveyCompletionTime = "ancile_study_last_survey_completion_time"
//    static public let kLastSurveyLaunchTime = "ancile_study_last_survey_launch_time"
//    static public let kEligible = "ancile_study_eligible"
//    static public let kPartcipantSince = "ancile_participant_since"
//    static public let kNotificationTime = "ancile_notification_time"
//    static public let kLocationsSet = "ancile_locations_set"
//    static public let kHomeLocationString = "ancile_home_location_string"
//    static public let kWorkLocationString = "ancile_work_location_string"
//
//    public func valueInState(forKey: String) -> NSSecureCoding? {
//        return self.get(key: forKey)
//    }
//
//    public func setValueInState(value: NSSecureCoding?, forKey: String) {
//        self.set(value: value, key: forKey)
//    }
//
//    public func set(value: NSSecureCoding?, key: String) {
//        RSAFKeychainStateManager.setValueInState(value: value, forKey: key)
//    }
//    public func get(key: String) -> NSSecureCoding? {
//        return RSAFKeychainStateManager.valueInState(forKey: key)
//    }
//
//    public func getManager() -> MCManager? {
//        return (UIApplication.shared.delegate as? AppDelegate)?.mcManager
//    }
//
//    public func getAncileClient() -> ANCClient? {
//        return (UIApplication.shared.delegate as? AppDelegate)?.ancileClient
//    }
//
//    public func reset() {
//        RSAFKeychainStateManager.clearKeychain()
//    }
//
//    //app specific state
//    open var consentDocURL: URL? {
//        get {
//            return self.get(key: Store.kConsentDocURL) as? URL
//        }
//        set {
//            if let url = newValue {
//                self.set(value: url as NSURL, key: Store.kConsentDocURL)
//            }
//            else {
//                self.set(value: nil, key: Store.kConsentDocURL)
//            }
//        }
//    }
//
//    open var isConsented: Bool {
//        return self.consentDocURL != nil
//    }
//
//    open var lastSurveyCompletionTime: Date? {
//        get {
//            return self.get(key: Store.kLastSurveyCompletionTime) as? Date
//        }
//        set {
//            if let date = newValue {
//                self.set(value: date as NSDate, key: Store.kLastSurveyCompletionTime)
//            }
//            else {
//                self.set(value: nil, key: Store.kLastSurveyCompletionTime)
//            }
//        }
//    }
//
//    open var lastSurveyLaunchTime: Date? {
//        get {
//            return self.get(key: Store.kLastSurveyLaunchTime) as? Date
//        }
//        set {
//            if let date = newValue {
//                self.set(value: date as NSDate, key: Store.kLastSurveyLaunchTime)
//            }
//            else {
//                self.set(value: nil, key: Store.kLastSurveyLaunchTime)
//            }
//        }
//    }
//
//    open var isEligible: Bool {
//        get {
//            if let number = self.get(key: Store.kEligible) as? NSNumber {
//                return number.boolValue
//            }
//            else {
//                return false
//            }
//        }
//        set {
//            let number = NSNumber(booleanLiteral: newValue)
//            self.set(value: number, key: Store.kEligible)
//        }
//    }
//
    open var homeLocation: CLLocationCoordinate2D? {
        get {
//            if let lat = self.get(key: "home_coordinate_lat") as? NSNumber,
//                let lng = self.get(key: "home_coordinate_lng") as? NSNumber {
//                return CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lng.doubleValue)
//            }
//            else {
//                return nil
//            }
            return nil
        }
        set {
//            if let location = newValue {
//                self.set(value: NSNumber(value: location.latitude), key: "home_coordinate_lat")
//                self.set(value: NSNumber(value: location.longitude), key: "home_coordinate_lng")
//            }
//            else {
//                self.set(value: nil, key: "home_coordinate_lat")
//                self.set(value: nil, key: "home_coordinate_lng")
//            }
//
        }
    }
//
//    open var homeLocationString: String? {
//        get {
//            return self.get(key: Store.kHomeLocationString) as? String
//        }
//        set {
//            if let home = newValue {
//                self.set(value: home as NSString, key: Store.kHomeLocationString)
//            }
//            else {
//                self.set(value: nil, key: Store.kHomeLocationString)
//            }
//
//        }
//    }
//
    open var workLocation: CLLocationCoordinate2D? {
        get {
//            if let lat = self.get(key: "work_coordinate_lat") as? NSNumber,
//                let lng = self.get(key: "work_coordinate_lng") as? NSNumber {
//                return CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lng.doubleValue)
//            }
//            else {
//                return nil
//            }
            return nil
        }
        set {
//            if let location = newValue {
//                self.set(value: NSNumber(value: location.latitude), key: "work_coordinate_lat")
//                self.set(value: NSNumber(value: location.longitude), key: "work_coordinate_lng")
//            }
//            else {
//                self.set(value: nil, key: "work_coordinate_lat")
//                self.set(value: nil, key: "work_coordinate_lng")
//            }

        }
    }
//
//    open var workLocationString: String? {
//        get {
//            return self.get(key: Store.kWorkLocationString) as? String
//        }
//        set {
//            if let work = newValue {
//                self.set(value: work as NSString, key: Store.kWorkLocationString)
//            }
//            else {
//                self.set(value: nil, key: Store.kWorkLocationString)
//            }
//
//        }
//    }
//
//    open var locationsSet: Bool {
//        get {
//            if let number = self.get(key: Store.kLocationsSet) as? NSNumber {
//                return number.boolValue
//            }
//            else {
//                return false
//            }
//        }
//        set {
//            let number = NSNumber(booleanLiteral: newValue)
//            self.set(value: number, key: Store.kLocationsSet)
//        }
//    }
//
//    open var participantSince: Date? {
//        get {
//            return self.get(key: Store.kPartcipantSince) as? Date
//        }
//        set {
//            if let date = newValue {
//                self.set(value: date as NSDate, key: Store.kPartcipantSince)
//            }
//            else {
//                self.set(value: nil, key: Store.kPartcipantSince)
//            }
//        }
//    }
//
//    open var notificationTime: DateComponents? {
//        get {
//            return self.get(key: Store.kNotificationTime) as? DateComponents
//        }
//        set {
//            if let dateComponents = newValue {
//                self.set(value: dateComponents as NSDateComponents, key: Store.kNotificationTime)
//            }
//            else {
//                self.set(value: nil, key: Store.kNotificationTime)
//            }
//        }
//    }
//
    
}

