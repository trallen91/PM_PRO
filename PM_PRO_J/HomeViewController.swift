//
//  HomeViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var surveys: [String] = []
    var store: RSStore!
    var curSurvey: String! // Variable to store which survey is being taken...maybe should be tuple of string/date
    
    @objc func settingsItemClicked()
    {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store = RSStore()
        
        self.title = "Home"
        self.navigationItem.hidesBackButton = true
        
        //This definition has to be in the viewDidLoad func to work, apparently.
        let rightBarButtonItem: UIBarButtonItem = {
            //programmatically make segue to the Settings ViewController
            let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(HomeViewController.settingsItemClicked))
            
            return barButtonItem
        }()
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        //for now create the surveys here...have to think about when/where I'd actually create them
        let outstandingSurveys = createSurveyArray()
        self.store.setValueInState(value: outstandingSurveys as NSSecureCoding, forKey: "outStandingSurveys")
        
        
        //retrieve the surveys from the stored surveys
        surveys = self.store.valueInState(forKey: "outStandingSurveys") as! [String]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

    
    func createSurveyArray() -> [String] {
        //LOAD IN THE SURVEY QUEUE
        let surveyQueue = SurveyQueue()
            
        surveyQueue.surveys = self.store.valueInState(forKey: "surveyQueue") as! [Survey]
        
        
        // GET CURRENT DATETIME
        let date = Date()
        let calendar = Calendar.current
        let curHour = calendar.component(.hour, from: date)
        let curMinutes = calendar.component(.minute, from: date)
        
        //GET DATETIME OF NOTIFICATION
        let seNotifHour = (self.store.valueInState(forKey: "sideEffectNotificationHour") as! NSString).intValue
        let seNotifMinute = (self.store.valueInState(forKey: "sideEffectNotificationMinutes") as! NSString).intValue
        
        //OUTSTANDING SURVEYS
        var outstandingSurveys: [String] = []
        
        if (curHour >= seNotifHour && curMinutes >= seNotifMinute) {
            print("It is after the notification time")
        }
        
        
        let survey1 = "Standardized Survey"
        let survey2 = "Well-Being Survey"
        let survey3 = "Side Effects Survey"

        outstandingSurveys.append(survey1)
        outstandingSurveys.append(survey2)
        outstandingSurveys.append(survey3)
        
        return outstandingSurveys
    }
    
    func removeFromSurveyQueue(surveyName : String) {
        var outstandingSurveys = self.store.valueInState(forKey: "outStandingSurveys") as! [String]
        
        for survey in outstandingSurveys {
            if (survey == surveyName) {
                //remove this survey
                print("\(surveyName) being removed")
            }
        }
        
        self.store.setValueInState(value: outstandingSurveys as NSSecureCoding, forKey: "outStandingSurveys")
        
    }
    
    
    @objc func standardSurveyClicked()
    {
        curSurvey = "Standardized Survey"
        let taskViewController = ORKTaskViewController(task: StandardSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func wbSurveyClicked()
    {
        curSurvey = "Well-Being Survey"
        let taskViewController = ORKTaskViewController(task: WellBeingSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func seSurveyClicked()
    {
        curSurvey = "Side Effects Survey"
        let taskViewController = ORKTaskViewController(task: SideEffectSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("Table View func1 executed")
        print(surveys.count)
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Table View func2 executed")
        let survey = surveys[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as! SurveyCell
        

        cell.surveyButton.setTitle(survey,for: .normal)
        cell.surveyButton.contentHorizontalAlignment = .left
        cell.surveyDate.text = "10/23/18"
        if(survey == "Standardized Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.standardSurveyClicked), for: .touchUpInside)
        }
        else if (survey == "Well-Being Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.wbSurveyClicked), for: .touchUpInside)
        }
        else if(survey == "Side Effects Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.seSurveyClicked), for: .touchUpInside)
        }

//        print(cell.surveyName.text)
        return cell
    }
}

extension HomeViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            //REMOVE THIS SURVEY FROM THE SURVEY QUEUE
            removeFromSurveyQueue(surveyName: curSurvey)
            //REFRESH THE VIEW SO THAT SCREEN IS UPDATED WITH NEW LIST??
            print("You completed this task!")
        }
    }
    
}
