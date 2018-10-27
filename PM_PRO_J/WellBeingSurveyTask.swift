//
//  WellBeingSurveyTask.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/27/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var WellBeingSurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Well Being Survey"
    instructionStep.text = "The following statements are statements that other people with your ilness have said are important.  Select the answer that describes your agreement with each statement, as it applies to the PAST 7 DAYS"
    steps += [instructionStep]
    
    let wbStatements = ["I have a lack of energy.",
                        "I have nausea.",
                        "Because of my physical condition, I have trouble meeting the needs of my family.",
                        "I have pain.",
                        "I am bothered by the side effects of treatment.",
                        "I feel ill.",
                        "I am forced to spend time in bed.",
                        "I feel close to my friends.",
                        "I get emotional support from my family.",
                        "I get support from my friends.",
                        "My family has accepted my illness",
                        "I am satisfied with family communication about my illness.",
                        "I feel close to my partner (or the person who is my main support).",
                        "I am satisfied with my sex life.",
                        "I feel sad.",
                        "I am satisfied with how I am coping with my illness.",
                        "I am losing hope in the fight against my illness.",
                        "I feel nervous.",
                        "I worry about dying.",
                        "I worry that my condition will get worse.",
                        "I am able to work (including work at home).",
                        "My work (including work at home) is fulfilling",
                        "I am able to enjoy life.",
                        "I have accepted my illness",
                        "I am sleeping well",
                        "I am enjoying the things I usually do for fun",
                        "I am content with the quality of my life right now"
                        ]
    
    for (index, statement) in wbStatements.enumerated() {
        
        print("Item \(index + 1): \(statement)")
        let statementIdentifier = "wbStatement \(index + 1)"
        
        let wbStep = ORKQuestionStep(identifier: statementIdentifier)
        wbStep.title = statement
        
        wbStep.answerFormat = ORKScaleAnswerFormat(maximumValue: 4, minimumValue: 0, defaultValue: 2, step: 1, vertical: false, maximumValueDescription: "Very much", minimumValueDescription: "Not at all")
        
        if (statement == "I am satisfied with my sex life." ) {
            wbStep.text = "Regardless of your current level of sexual activity, please answer the following question.  If you prefer not to answer, you may skip this question."
            wbStep.isOptional = true
        }
        else {
            wbStep.isOptional = false
        }
        steps += [wbStep]
    }
    
    return ORKOrderedTask(identifier: "WellBeingSurveyTask", steps: steps)
}
