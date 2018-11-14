//
//  ViewController.swift
//  PM_PRO_2
//
//  Created by Travis Allen on 10/5/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import UIKit
import ResearchKit
import ResearchSuiteTaskBuilder
import LS2SDK
import ResearchSuiteAppFramework

class IntroViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func learnMore(_ sender: UIButton) {
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.launchLogin()
    }
    
    func launchLogin(){
        
        guard let signInActivity = AppDelegate.loadScheduleItem(filename: "login.json"),
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let steps = appDelegate.taskBuilder.steps(forElement: signInActivity.activity as JsonElement) else {
                return
        }
        
        let task = ORKOrderedTask(identifier: signInActivity.identifier, steps: steps)
        
        let taskFinishedHandler: ((ORKTaskViewController, ORKTaskViewControllerFinishReason, Error?) -> ()) = { [weak self] (taskViewController, reason, error) in
            
            //when done, tell the app delegate to go back to the correct screen
            self?.dismiss(animated: true, completion: {
                
                if error == nil {
                    //I'D LIKE TO DO A CHECK BASED ON WHETHER OR NOT THE USER IS
                    //IF USER IS NOT ONBOARDED YET:
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "OnboardingSB", bundle: Bundle.main)
                        let vc = storyboard.instantiateInitialViewController()
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.transition(toRootViewController: vc!, animated: true)
                    }
                    //ELSE (THEY ARE ONBOARDED), GO STRAIGHT HOME
//                    DispatchQueue.main.async {
//                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                        let vc = storyboard.instantiateInitialViewController()
//                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        appDelegate.transition(toRootViewController: vc!, animated: true)
//                    }
                }
                else {
                    NSLog(String(describing:error))
                }
                
            })
            
        }
        
        let tvc = RSAFTaskViewController(
            activityUUID: UUID(),
            task: task,
            taskFinishedHandler: taskFinishedHandler
        )
        
        self.present(tvc, animated: true, completion: nil)
        
    }
}



