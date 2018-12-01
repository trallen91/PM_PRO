//
//  LocationManager.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 11/30/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager
    let store: RSStore!
    
    var initialHome = false
    var initialWork = false
    var initialHospital = false
    
    static let radius = 150.0
    
    override public init() {
        self.store = RSStore()
        self.locationManager = CLLocationManager()
        
        super.init()
        
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        //
        self.locationManager.distanceFilter = 100
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion){
        //self.recordEvent(regionIdentifier: region.identifier, action: .enter)
        //create logical location result-type of object (from ANC)
        //Add LS2 Datapoint
        print("You are entering \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region:CLRegion){
        //self.recordEvent(regionIdentifier: region.identifier, action: .exit)
        print("You are exiting \(region.identifier)")
    }
    
    var _home: CLLocationCoordinate2D? = nil
    var home: CLLocationCoordinate2D? {
        get {
            if self._home == nil {
                if let home_lat = self.store.valueInState(forKey: "home_lat") as? NSNumber, let home_lng = self.store.valueInState(forKey: "home_lng") as? NSNumber {
                    self._home = CLLocationCoordinate2D(latitude: home_lat.doubleValue, longitude: home_lng.doubleValue)
                }
            }
            return self._home
        }
        set(newValue) {
            let oldValue = self._home
            self._home = newValue
            
            self.store.set(value: newValue?.latitude as! NSNumber, key: "home_lat")
            self.store.set(value: newValue?.longitude as! NSNumber, key: "home_lng")

            debugPrint("Setting Home")
            
            let homeRegion = CLCircularRegion(center: newValue!, radius: LocationManager.radius, identifier: "home")
            
            self.locationManager.startMonitoring(for: homeRegion)
            
            if (oldValue != nil) {
                let oldHomeRegion = CLCircularRegion(center: oldValue!, radius: LocationManager.radius, identifier: "home")
                self.locationManager.stopMonitoring(for: oldHomeRegion)
            }
            
            //if let currentHome = newValue {
                //if CLLocationManager.authorizationStatus() == .authorizedAlways {
                    
                    //let region = CLCircularRegion(center: currentHome, radius: ANCLocationManager.radius, identifier: "home")
                    //self.locationManager.startMonitoring(for: region)
                    //self.initialHome = true
                    //debugPrint("Requesting State For Home")
                    
                    //These requests don't seem to always be working
                    //Add a delay
                    //let locationManager = self.locationManager
//                    delay(5.0) {
//                        locationManager.requestState(for: region)
//                    }
                    
                //}
            //}
//            else {
//
//                //clear in store
//                if let previousHome = oldValue {
//                    let region = CLCircularRegion(center: previousHome, radius: ANCLocationManager.radius, identifier: "home")
//                    self.locationManager.stopMonitoring(for: region)
//                }
//            }
        }
        
    }
    
    var _work: CLLocationCoordinate2D? = nil
    var work: CLLocationCoordinate2D? {
        get {
            if self._work == nil {
                if let work_lat = self.store.valueInState(forKey: "work_lat") as? NSNumber, let work_lng = self.store.valueInState(forKey: "work_lng") as? NSNumber {
                    self._work = CLLocationCoordinate2D(latitude: work_lat.doubleValue, longitude: work_lng.doubleValue)
                }
            }
            return self._work
        }
        set(newValue) {
            let oldValue = self._work
            self._work = newValue
            
            self.store.set(value: newValue?.latitude as! NSNumber, key: "work_lat")
            self.store.set(value: newValue?.longitude as! NSNumber, key: "work_lng")
            
            debugPrint("Setting Work")
            
            let workRegion = CLCircularRegion(center: newValue!, radius: LocationManager.radius, identifier: "work")
            
            self.locationManager.startMonitoring(for: workRegion)
            
            if (oldValue != nil) {
                let oldWorkRegion = CLCircularRegion(center: oldValue!, radius: LocationManager.radius, identifier: "work")
                self.locationManager.stopMonitoring(for: oldWorkRegion)
            }
        }
        
    }
    
    var _hospital: CLLocationCoordinate2D? = nil
    var hospital: CLLocationCoordinate2D? {
        get {
            if self._hospital == nil {
                if let hospital_lat = self.store.valueInState(forKey: "hospital_lat") as? NSNumber, let hospital_lng = self.store.valueInState(forKey: "hospital_lng") as? NSNumber {
                    self._hospital = CLLocationCoordinate2D(latitude: hospital_lat.doubleValue, longitude: hospital_lng.doubleValue)
                }
            }
            return self._hospital
        }
        set(newValue) {
            let oldValue = self._hospital
            self._hospital = newValue
        
            self.store.set(value: newValue?.latitude as! NSNumber, key: "hospital_lat")
            self.store.set(value: newValue?.longitude as! NSNumber, key: "hospital_lng")
            
            debugPrint("Setting Hospital")
            
            let hospitalRegion = CLCircularRegion(center: newValue!, radius: LocationManager.radius, identifier: "hospital")
            
            self.locationManager.startMonitoring(for: hospitalRegion)
            
            if (oldValue != nil) {
                let oldhospitalRegion = CLCircularRegion(center: oldValue!, radius: LocationManager.radius, identifier: "hospital")
                self.locationManager.stopMonitoring(for: oldhospitalRegion)
            }
        }
        
    }
}
