//
//  EligibilityViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import UIKit
import ResearchKit

class EligibilityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Eligibility"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkEligTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: EligibilityTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
}

extension EligibilityViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            var allYes : Bool = true
            
            let taskResult = taskViewController.result.results
            
            for stepResults in taskResult! as! [ORKStepResult]
            {
                for result in stepResults.results!
                {
                    print(result.identifier)
                    let eligAnswerResult = result as! ORKBooleanQuestionResult
                    let answer = eligAnswerResult.booleanAnswer!
                    
                    print(answer)
                    
                    if answer == 0 {
                        allYes = false
                    }
                    
                }
            }
            print("Eligibility Complete")
            if (allYes) {
                print("Is Eligible")
                self.performSegue(withIdentifier: "isEligibleSegue", sender: nil)
            }
            else {
                print("Is Ineligible")
                self.performSegue(withIdentifier: "isIneligibleSegue", sender: nil)
            }
        }
    }
    
}
