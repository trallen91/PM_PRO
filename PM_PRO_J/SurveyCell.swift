//
//  SurveyCell.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit

class SurveyCell: UITableViewCell {
    
    @IBOutlet weak var surveyName: UILabel!
    @IBOutlet weak var surveyDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
