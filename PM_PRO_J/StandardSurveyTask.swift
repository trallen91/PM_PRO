//
//  StandardSurveyTask.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/23/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var StandardSurveyTask: ORKNavigableOrderedTask {
    var steps = [ORKStep]()
    
    //1 - Declare Constants for step identifiers
    
    let question2ID = "question 2"
    let completionChoice2ID = "completionChoice 2"
    
    //INSTRUCTION STEP
    let instructionID = "Instruction Step"
    let instStep = ORKInstructionStep(identifier: instructionID)
    instStep.title = "Standardized Survey"
    instStep.detailText = "This bi-weekly survey is intended to monitor changes/updates in therapies, clinical care and histories since your last survey"
    
    steps += [instStep]
    
    // NEW TREATMENTS STEP
    
    //yes-no
    let newTreatQID = "new treatments question"
    let newTreatQStep = ORKQuestionStep(identifier: newTreatQID, title: "Have you started any new treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [newTreatQStep]
    
    //if yes section
    let newTreatDetailsID = "newTreatDetailsID"
    let newTreatDetailsStep = ORKFormStep(identifier: newTreatDetailsID)
    newTreatDetailsStep.title = "New Treatment Details"
    let newTreatName = ORKFormItem(identifier:"newTreatName", text:"Enter Name of Treatment(s)", answerFormat: ORKTextAnswerFormat())
    let newTreatDate = ORKFormItem(identifier:"newTreatDate", text:"Enter Approximate Start Date(s)", answerFormat: ORKTextAnswerFormat())
    newTreatDetailsStep.formItems = [newTreatName, newTreatDate]
    steps += [newTreatDetailsStep]
    
    let question2 = ORKQuestionStep(identifier: question2ID, title: "How many apps do you download pweek?", answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "Apps per week"))
    
    steps += [question2]
    
    //    let completionStep1 = ORKCompletionStep(identifier: completionChoice1ID)
    //    completionStep1.title = "Thank you for letting us know that you are Softwareitis free!"
    
    //    steps += [completionStep1]
    
    let completionStep2 = ORKCompletionStep(identifier: completionChoice2ID)
    completionStep2.title = "Thank you for taking our survey!"
    
    steps += [completionStep2]
    
    let task = ORKNavigableOrderedTask(identifier: "StandardSurveyTask", steps: steps)
    
    //1
    let newTreatQPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: newTreatQID), expectedAnswer: false)
    
    //2
    let predicatedNavigationRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(newTreatQPredicate, question2ID)], defaultStepIdentifierOrNil: nil)
    
    //3
    task.setNavigationRule(predicatedNavigationRule, forTriggerStepIdentifier: newTreatQID)
    
    //    //1
    //    let directNavigationRule1 = ORKDirectStepNavigationRule(destinationStepIdentifier: completionChoice2ID)
    //    task.setNavigationRule(directNavigationRule1, forTriggerStepIdentifier: question2ID)
    //
    //    //2
    //    let directNavigationRule2 = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    //    task.setNavigationRule(directNavigationRule2, forTriggerStepIdentifier: newTreatDetailsID)
    
    
    return task
}
