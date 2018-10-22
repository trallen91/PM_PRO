//
//  HomeViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var surveys: [String] = []

    @objc func settingsItemClicked()
    {
        self.performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.navigationItem.hidesBackButton = true
        
        //This definition has to be in the viewDidLoad func to work, apparently.
        let rightBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(HomeViewController.settingsItemClicked))
            
            return barButtonItem
        }()
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
//        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "barButtonItemClicked:"), animated: true)
//        self.navigationItem.rightBarButtonItem.
//        addTarget(self, action: "buttonClicked:", for: .touchUpInside)
        
        //programmatically make segue to the Settings ViewController
        
        surveys = createSurveyArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

    
    func createSurveyArray() -> [String] {
        //this function should load all of the outstanding surveys
        //for now, just hardcode the 3 survey names
        var outstandingSurveys: [String] = []
        
        let survey1 = "Standardized Survey"
        let survey2 = "Well-Being Survey"
        let survey3 = "Side Effects Survey"

        outstandingSurveys.append(survey1)
        outstandingSurveys.append(survey2)
        outstandingSurveys.append(survey3)
        
        return outstandingSurveys
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        
        cell.surveyName.text = survey
        print(cell.surveyName.text)
        return cell
    }
}
