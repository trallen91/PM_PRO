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

class GeofenceSetViewController: UIViewController {
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Enter Locations"
        self.store = RSStore()
    }
    
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
        let myStore = Store()
        let myLocMgr = ANCLocationManager(store: myStore)
        for stepResults in taskResult! as! [ORKStepResult]
        {
            print("---")
            for result in stepResults.results!
            {
                print(result.identifier)
                let locAnswerResult = result as! ORKLocationQuestionResult
                let loc = locAnswerResult.locationAnswer!
                print(loc.coordinate)
                
                if result.identifier == "homeAddress"
                {
                    print("Home Address: ")
                    myLocMgr.home = loc.coordinate
                    
                }
                if result.identifier == "workAddress"
                {
                    print("Work Address: ")
                    print(myLocMgr.work = loc.coordinate)
                }
                if result.identifier == "hospitalAddress"
                {
                    print("Hospital Address: ")
                    //                    print(myLocMgr.work)
                }
            }
        }
        
        if reason == .completed {
            self.store.set(value: true as NSSecureCoding, key: "hasSetGeofence")
            self.performSegue(withIdentifier: "firstSetTimeSegue", sender: nil)
        }
        
    }
    
}
