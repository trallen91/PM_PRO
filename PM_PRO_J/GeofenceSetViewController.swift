//
//  GeofenceSetViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/20/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class GeofenceSetViewController: UIViewController, CLLocationManagerDelegate {
    var store: RSStore!
    var locMgr: LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Enter Locations"
        self.store = RSStore()
        
        self.locMgr = LocationManager()
        
//        locationManager.delegate = self
//
//        locationManager.requestAlwaysAuthorization()
//
//        locationManager.startUpdatingLocation()
////
//        locationManager.distanceFilter = 100
//
//        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 43.61871, longitude: -116.214607), radius: 150, identifier: "Boise")
//
//        locationManager.startMonitoring(for: geoFenceRegion)
    }
    
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("You are entering \(region.identifier)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
//        print("You are leaving \(region.identifier)")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func geoSetTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: GeofenceLocationsTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension GeofenceSetViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)

        let taskResult = taskViewController.result.results
        //let myStore = Store()
        //let myLocMgr = ANCLocationManager(store: myStore)
        for stepResults in taskResult! as! [ORKStepResult]
        {
            print("---")
            for result in stepResults.results!
            {
                print(result.identifier)
                let locAnswerResult = result as! ORKLocationQuestionResult
                let loc = locAnswerResult.locationAnswer!
//                print(loc.coordinate)
                
                if result.identifier == "homeAddress"
                {
                    print("Home Address: ")
                    print(loc.coordinate)
                    //myLocMgr.home = loc.coordinate
                    
                    self.locMgr.home = loc.coordinate
//                    let homeGeoFenceRegion:CLCircularRegion = CLCircularRegion(center: loc.coordinate, radius: 150, identifier: "Home")
//                    locationManager.startMonitoring(for: homeGeoFenceRegion)
                    
                }
                if result.identifier == "workAddress"
                {
                    print("Work Address: ")
                    print(loc.coordinate)
                    //myLocMgr.work = loc.coordinate
//                    let workGeoFenceRegion:CLCircularRegion = CLCircularRegion(center: loc.coordinate, radius: 150, identifier: "Work")
//                    locationManager.startMonitoring(for: workGeoFenceRegion)
                    
                }
                if result.identifier == "hospitalAddress"
                {
                    print("Hospital Address: ")
                    print(loc.coordinate)
                    //myLocMgr.work = loc.coordinate
//                    let hospitalGeoFenceRegion:CLCircularRegion = CLCircularRegion(center: loc.coordinate, radius: 150, identifier: "Hospital")
//                    locationManager.startMonitoring(for: hospitalGeoFenceRegion)
                }
            }
        }
        
        if reason == .completed {
            //self.store.set(value: true as NSSecureCoding, key: "hasSetGeofence")
            //self.performSegue(withIdentifier: "firstSetTimeSegue", sender: nil)
            
            print("Should now segue -- uncomment both lines above to restore functionality")
        }
        
    }
    
}
