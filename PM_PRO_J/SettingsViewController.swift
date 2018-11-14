//
//  SettingsViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Settings"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func geoChangeTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: GeofenceLocationsTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }

    @IBAction func signOutTapped(_ sender: UIButton) {
        self.signOut()
    }
    
    @IBAction func timeChangeTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: SetSurveyTimeTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func signOut() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.signOut()
    }
}

extension SettingsViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            print("Task Completed")
        }
        
    }
    
}
