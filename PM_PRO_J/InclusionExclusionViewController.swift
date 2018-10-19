//
//  InclusionExclusionViewController.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/17/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit

class InclusionExclusionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var criteria: [String] = []
    
//    let rightBarButtonItem: UIBarButtonItem = {
//        let barButtonItem = UIBarButtonItem(title: "Continue", style: .plain, target: self, action: nil)
////        barButtonItem.tintColor = UIColor.blue
//        barButtonItem.isEnabled = false
//        return barButtonItem
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Eligibility"
//        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        criteria = createCriteriaArray()
        
//        tableView.frame = CGRectMake(0, 50, 320, 200)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func createCriteriaArray() -> [String] {
        var tempCriteria: [String] = []
        
        let criterion1 = "You are 18 Years or Older"
        let criterion2 = "You have had an Android or iPhone device for at least one year prior to enrolling in the study"
        let criterion3 = "You have a Google account that is actively in use"
        let criterion4 = "Spend time searching and browsing web on a weekly basis"
        let criterion5 = "You spend time out of the house each day when feeling well (i.e. not largely home-bound"
        tempCriteria.append(criterion1)
        tempCriteria.append(criterion2)
        tempCriteria.append(criterion3)
        tempCriteria.append(criterion4)
        tempCriteria.append(criterion5)
        
        return tempCriteria
        
        
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

extension InclusionExclusionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Table View func1 executed")
        print(criteria.count)
        return criteria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Table View func2 executed")
        let criterion = criteria[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EligibilityCell") as! EligibilityCell
        
        cell.criterion.text = criterion
        print(cell.criterion.text)
        return cell
    }
}
