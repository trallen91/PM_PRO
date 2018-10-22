//
//  LoginController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/20/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class LoginViewController: UIViewController {
    var justSignedOut : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Log In"
        if (justSignedOut) {
            self.navigationItem.hidesBackButton = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
