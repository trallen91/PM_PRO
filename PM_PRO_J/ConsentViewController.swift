//
//  ConsentViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/19/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class ConsentViewController: UIViewController {
    var store: RSStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var isConsented : Bool = false
//        self.store = RSStore()
//        if (self.store.valueInState(forKey: "isConsented") != nil) {
//            isConsented = self.store.valueInState(forKey: "isConsented") as! Bool
//        }
//        if(isConsented){
//            self.performSegue(withIdentifier: "consentCompleteSegue", sender: nil)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func consentTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self as ORKTaskViewControllerDelegate
        present(taskViewController, animated: true, completion: nil)
        
    }
}
extension ConsentViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        
        if reason == .completed {
            self.store.set(value: true as NSSecureCoding, key: "isConsented")
            self.performSegue(withIdentifier: "consentCompleteSegue", sender: nil)
        }
        taskViewController.dismiss(animated: true, completion: nil)
//        taskViewController.shouldPerformSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//
//
//        self.performSegue(withIdentifier: "consentCompleteSegue", sender: nil)
//        print(reason)
//        print(taskViewController.result.results)
        
        
        
    }
    
}
