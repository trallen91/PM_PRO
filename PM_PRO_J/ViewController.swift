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

    @IBAction func learnMore(_ sender: UIButton) {
        
    }
    @IBAction func joinStudy(_ sender: UIButton) {
    }

    @IBAction func hitBackEnd(_ sender: UIButton) {
        // stolen from https://dzone.com/articles/how-to-start-building-a-backend-for-your-ios-app-w
        let json = ["user":"larry"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let url = NSURL(string: "http://127.0.0.1:5000/api/get_messages")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                    print("Result -> \(result)")
                } catch {
                    print("Error -> \(error)")
                }
            }
            task.resume()
        } catch {
            print(error)
        }
    }
}



