//
//  ViewController.swift
//  PM_PRO_2
//
//  Created by Travis Allen on 10/5/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import ResearchKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func consentTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    @IBAction func surveyTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    @IBAction func geoTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: GeofenceLocationsTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
}

extension ViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        print(reason)
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
        
    }
    
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
}


