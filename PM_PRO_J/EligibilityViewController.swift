//
//  EligibilityViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import UIKit
import ResearchKit
import ResearchSuiteTaskBuilder
import ResearchSuiteAppFramework

class EligibilityViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var eligibilityAssessmentItem: RSAFScheduleItem!
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Eligibility"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //back when I was doing it without the Results Processor
//    @IBAction func checkEligTapped(_ sender: UIButton) {
////        let taskViewController = ORKTaskViewController(task: EligibilityTask, taskRun: nil)
////        taskViewController.delegate = self
////        present(taskViewController, animated: true, completion: nil)
//
//
//    }
    
    @IBAction func checkEligibilityTapped(_ sender: UIButton) {
        self.eligibilityAssessmentItem = AppDelegate.loadScheduleItem(filename:"eligibility.json")
        self.launchActivity(forItem: (self.eligibilityAssessmentItem)!)
    }
    
    func launchActivity(forItem item: RSAFScheduleItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let steps = appDelegate.taskBuilder.steps(forElement: item.activity as JsonElement) else {
                return
        }
        
        let task = ORKOrderedTask(identifier: item.identifier, steps: steps)
        
        
          let taskFinishedHandler: ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> ()) = { [weak self] (taskViewController, reason, error) in
            
             if reason == ORKTaskViewControllerFinishReason.completed {
                let taskResult = taskViewController.result

                appDelegate.resultsProcessor.processResult(taskResult: taskResult, resultTransforms: item.resultTransforms)
                
                var allYes : Bool = true
                
                let taskResultS = taskResult.results
                
                for stepResults in taskResultS! as! [ORKStepResult]
                {
                    for result in stepResults.results!
                    {
                        print(result.identifier)
                        let eligAnswerResult = result as! ORKChoiceQuestionResult
                        let single_answer_arr = eligAnswerResult.answer as! NSArray
                        
                        let answer = single_answer_arr[0] as! NSString
    
                        print(answer)
    
                        if answer == "No" {
                            allYes = false
                        }
    
                    }
                }

                self?.dismiss(animated: true, completion: {

                    if (allYes) {
                        print("Is Eligible")
                        self?.performSegue(withIdentifier: "isEligibleSegue", sender: nil)
                    }
                    else {
                        print("Is Ineligible")
                        self?.performSegue(withIdentifier: "isIneligibleSegue", sender: nil)
                    }

                })
            }
        }
        
        let tvc = RSAFTaskViewController(
            activityUUID: UUID(),
            task: task,
            taskFinishedHandler: taskFinishedHandler
        )
        
        self.present(tvc, animated: true, completion: nil)
    }
}

//extension EligibilityViewController : ORKTaskViewControllerDelegate {
//    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
//
//
//
//        taskViewController.dismiss(animated: true, completion: nil)
//
//        if reason == .completed {
//            var allYes : Bool = true
//
//            let taskResult = taskViewController.result
//
//            let taskResultS = taskViewController.result.results
//
//            for stepResults in taskResultS! as! [ORKStepResult]
//            {
//                for result in stepResults.results!
//                {
//                    print(result.identifier)
//                    let eligAnswerResult = result as! ORKBooleanQuestionResult
//                    let answer = eligAnswerResult.booleanAnswer!
//
//                    print(answer)
//
//                    if answer == 0 {
//                        allYes = false
//                    }
//
//                }
//            }
//            print("Eligibility Complete")
//            if (allYes) {
//                print("Is Eligible")
//                self.performSegue(withIdentifier: "isEligibleSegue", sender: nil)
//            }
//            else {
//                print("Is Ineligible")
//                self.performSegue(withIdentifier: "isIneligibleSegue", sender: nil)
//            }
//        }
//    }
//
//}
