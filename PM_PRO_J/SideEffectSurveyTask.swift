//
//  SideEffectSurveyTask.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/27/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var SideEffectSurveyTask: ORKOrderedTask {
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Side Effect Survey"
    instructionStep.text = "The following statements are statements that other people with your illness have said are important.  Select the answer that describes your agreement with each statement, as it applies to TODAY."
    steps += [instructionStep]
    
    let seStatements = ["I am losing weight.",
                        "I have a good appetite.",
                        "I have aches and pains that bother me.",
                        "I have certain parts of my body where I experience pain.",
                        "My pain keeps me from doing things I want to do.",
                        "I am satisfied with my present comfort level.",
                        "I am able to feel like a man.",
                        "I have trouble moving my bowels.",
                        "I have difficulty urinating.",
                        "I urinate more frequently than usual.",
                        "My problems with urinating limit my activities.",
                        "I am able to have and maintain an erection."]
    
    let statementChoices = [
        ORKTextChoice(text: "Not at all", value: 0 as NSNumber),
        ORKTextChoice(text: "A little bit", value: 1 as NSNumber),
        ORKTextChoice(text: "Somewhat", value: 2 as NSNumber),
        ORKTextChoice(text: "Quite a bit", value: 3 as NSNumber),
        ORKTextChoice(text: "Very much", value: 4 as NSNumber)
    ]
    
    let statementAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: statementChoices)
    
 
    
    for (index, statement) in seStatements.enumerated() {
        
        print("Item \(index + 1): \(statement)")
        let statementIdentifier = "survey.seStatement \(index + 1)"
        
        
        let seStep = ORKQuestionStep(identifier:statementIdentifier)
        
        seStep.answerFormat = statementAnswerFormat
        seStep.title = statement
        
        
        seStep.isOptional = false

        steps += [seStep]
    }
    
    return ORKOrderedTask(identifier: "SideEffectSurveyTask", steps: steps)
}
