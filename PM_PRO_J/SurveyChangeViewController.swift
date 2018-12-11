//
//  SurveyTimeCHANGE.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 12/11/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation

import UIKit
import ResearchKit

class SurveyChangeViewController: UIViewController {
    var store: RSStore!
    var sqMgr: SurveyQueueManager!
    var surveyTimeMgr: SurveyTimesManager!
    var surveyNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Set Survey Times"
        self.store = RSStore()
        self.sqMgr = SurveyQueueManager()
        self.surveyTimeMgr = SurveyTimesManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setSurveyTapped(_ sender: UIButton) {
//        let taskViewController = ORKTaskViewController(task: SetSurveyTimeTask, taskRun: nil)
//        taskViewController.delegate = self
//        present(taskViewController, animated: true, completion: nil)
    }
}

//extension SurveyChangeViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        print("Table View func1 executed")
//        return outstandingSurveys.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //        print("Table View func2 executed")
//        let survey = outstandingSurveys[indexPath.row]
//        
//        
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        let displayDate = dateFormatter.string(from: survey.OpenDate as Date)
//        
//        
//        let surveyName = survey.Name as! String
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as! SurveyCell
//        cell.surveyButton.setTitle(surveyName,for: .normal)
//        cell.surveyButton.contentHorizontalAlignment = .left
//        cell.surveyDate.text = displayDate
//        cell.surveyID = String(UInt(bitPattern: ObjectIdentifier(survey)))
//        
//        print("Unique String: ")
//        print(cell.surveyID)
//        if(surveyName == "Standardized Survey") {
//            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.standardSurveyClicked), for: .touchUpInside)
//        }
//        else if (surveyName == "Well-Being Survey") {
//            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.wbSurveyClicked), for: .touchUpInside)
//        }
//        else if(surveyName == "Side-Effects Survey") {
//            cell.surveyButton.addTarget(self, action: #selector(HomeViewController.seSurveyClicked), for: .touchUpInside)
//        }
//        
//        return cell
//    }
//}
