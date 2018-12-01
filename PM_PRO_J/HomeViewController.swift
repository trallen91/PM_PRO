//
//  HomeViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import ResearchKit


import ResearchSuiteResultsProcessor
import Gloss
import ReSwift

class HomeViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var surveyQueue: [Survey]!
    var outstandingSurveys: [Survey]!
    
    var store: RSStore!
    
    var curSurveyId: String!
    
    var curSurveyName: NSString! // HACKY WORK-AROUND WHICH ONLY WORKS IF THERE IS ONE OF EACH TYPE OF SURVEY
    
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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retrieve the surveys from the stored surveys
        surveyQueue = updateSurveyQueue()
        outstandingSurveys = getOutstandingSurveys(surveyQ: surveyQueue) // This doesn't refresh Table
    }
    
    func updateSurveyQueue() -> [Survey] {
        surveyQueue =  self.store.valueInState(forKey: "surveyQueue") as! [Survey]
        var updatedSurveyQ : [Survey] = []
        
        // GET CURRENT DATETIME
        let currentDate = NSDate()
        
        for survey in surveyQueue {
            let surveyType = survey.Name
            if (currentDate.laterDate(survey.ExpirationDate as Date) == currentDate as Date) {//means survey is expired...this shouldn't be the only way to add new surveys to queue, but can revisit
                var newSurvey : Survey!
                let newSurveyOpenDate = Calendar.current.date(byAdding: .day, value: survey.DaysBetweenSurveys as! Int, to: survey.OpenDate! as Date) as! NSDate
                
                if (surveyType == "Standardized Survey") { //SHOULD THIS BE TYPE CHECKING?
                    newSurvey = StandardizedSurvey(OpenDate: newSurveyOpenDate)
                }
                else if (surveyType == "Well-Being Survey") {
                    newSurvey = WellbeingSurvey(OpenDate: newSurveyOpenDate)
                }
                else if (surveyType == "Side-Effects Survey") {
                    newSurvey = SideEffectSurvey(OpenDate: newSurveyOpenDate)
                }

                updatedSurveyQ.append(newSurvey)
            }
            else {
                updatedSurveyQ.append(survey)
            }
        }
     
        //sort updatedSurveyQ by OpenDate
        self.store.setValueInState(value: updatedSurveyQ as! NSSecureCoding, forKey: "surveyQueue")
        return updatedSurveyQ
     
     }
    
    func getOutstandingSurveys(surveyQ : [Survey]) -> [Survey] {

        //OUTSTANDING SURVEYS
        var outstandingSurveys: [Survey] = []
        
        for survey in surveyQ {
            if !(survey.IsComplete) {
                outstandingSurveys.append(survey)
            }
        }
        
        return outstandingSurveys
    }
    
    func markAsComplete(surveyName : NSString) {
        var curQ = self.store.valueInState(forKey: "surveyQueue") as! [Survey]
        var updatedSurveyQ : [Survey] = []
        
        for survey in curQ {
            if (survey.Name == surveyName) {
                survey.IsComplete = true
            }
            updatedSurveyQ.append(survey)
        }
        
        self.store.setValueInState(value: updatedSurveyQ as! NSSecureCoding, forKey: "surveyQueue")
        
    }
    
    @objc func surveyClicked(survey : Survey ){ //figure out how to pass survey parameter thru selector
        curSurveyId = String(UInt(bitPattern: ObjectIdentifier(survey)))
        var surveyTVC : ORKTaskViewController!
        if (survey.Name == "Standardized Survey") {
            surveyTVC = ORKTaskViewController(task: StandardSurveyTask, taskRun: nil)
        }
        else if (survey.Name == "Well-Being Survey") {
            surveyTVC = ORKTaskViewController(task: WellBeingSurveyTask, taskRun: nil)
        }
        else if (survey.Name == "Side-Effects Survey") {
            surveyTVC = ORKTaskViewController(task: SideEffectSurveyTask, taskRun: nil)
        }
        
        surveyTVC.delegate = self
        present(surveyTVC, animated: true, completion: nil)
    }
    
    @objc func standardSurveyClicked(sender: UIButton)
    {
        curSurveyName = "Standardized Survey"
        let taskViewController = ORKTaskViewController(task: StandardSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func wbSurveyClicked()
    {
        curSurveyName = "Well-Being Survey"
        let taskViewController = ORKTaskViewController(task: WellBeingSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @objc func seSurveyClicked()
    {
        curSurveyName = "Side-Effects Survey"
        let taskViewController = ORKTaskViewController(task: SideEffectSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("Table View func1 executed")
        return outstandingSurveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Table View func2 executed")
        let survey = outstandingSurveys[indexPath.row]
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let displayDate = dateFormatter.string(from: survey.OpenDate as Date)
        
        
        let surveyName = survey.Name as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as! SurveyCell
        cell.surveyButton.setTitle(surveyName,for: .normal)
        cell.surveyButton.contentHorizontalAlignment = .left
        cell.surveyDate.text = displayDate
        cell.surveyID = String(UInt(bitPattern: ObjectIdentifier(survey)))
        
        print("Unique String: ")
        print(cell.surveyID)
        if(surveyName == "Standardized Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.standardSurveyClicked), for: .touchUpInside)
        }
        else if (surveyName == "Well-Being Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.wbSurveyClicked), for: .touchUpInside)
        }
        else if(surveyName == "Side-Effects Survey") {
            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.seSurveyClicked), for: .touchUpInside)
        }

        return cell
    }
}

extension HomeViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        taskViewController.dismiss(animated: true, completion: nil)
        
        if reason == .completed {
            //create results transform object
            let taskResult = taskViewController.result
            
            let surveyRT = AppDelegate.getSurveyMapping()
            
            appDelegate!.resultsProcessor.processResult(taskResult: taskResult, resultTransforms: surveyRT)
            
            //REMOVE THIS SURVEY FROM THE SURVEY QUEUE
            markAsComplete(surveyName: curSurveyName)
        }
    }
    
}
