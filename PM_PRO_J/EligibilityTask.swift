//
//  EligibilityTask.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/22/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var EligibilityTask: ORKOrderedTask {
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Check Eligibility"
    instructionStep.text = "Please answer 'Yes' or 'No' to the following Inclusion Criteria"
    steps += [instructionStep]
    
    let inclusionCriteria = ["You are 18 Years or Older", "You have had an Android or iPhone device for at least one year prior to enrolling in the study", "You have a Google account that is actively in use", "Spend time searching and browsing web on a weekly basis", "You spend time out of the house each day when feeling well (i.e. not largely home-bound)"]
    
    for (index, criterion) in inclusionCriteria.enumerated() {
        print("Item \(index + 1): \(criterion)")
        let critIdentifier = "criteria \(index + 1)"
        
        let criterionStep = ORKQuestionStep(identifier: critIdentifier)
        criterionStep.title = criterion
        
        criterionStep.answerFormat = ORKBooleanAnswerFormat()
        criterionStep.isOptional = false
        steps += [criterionStep]
    }
    
    return ORKOrderedTask(identifier: "EligibilityTask", steps: steps)
}
