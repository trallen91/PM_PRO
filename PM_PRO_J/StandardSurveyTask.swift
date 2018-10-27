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
    
    
    //CHANGE TREATMENTS STEP
    //yes-no
    let changeTreatQID = "change treatments question"
    let changeTreatQStep = ORKQuestionStep(identifier: changeTreatQID, title: "Have you changed any of your treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [changeTreatQStep]
    
    //if yes section
    let changeTreatDetailsID = "changeTreatDetailsID"
    let changeDetailsStep = ORKFormStep(identifier: changeTreatDetailsID)
    changeDetailsStep.title = "Change Treatment Details"
    
    let changeTreatName = ORKFormItem(identifier:"changeTreatName", text:"Enter name of treatment(s) changed", answerFormat: ORKTextAnswerFormat())
    let changeTreatDetails = ORKFormItem(identifier:"changeTreatDetails", text:"Details of treatment modification, inlcuding dose, regimen, etc.", answerFormat: ORKTextAnswerFormat())

    changeDetailsStep.formItems = [changeTreatName, changeTreatDetails]
    
    steps += [changeDetailsStep]
    
    
    //STOP TREATMENTS SECTION
    let stopTreatQID = "Stop Treatments Questions"
    let stopTreatQStep = ORKQuestionStep(identifier: stopTreatQID, title: "Have you stopped any of your treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [stopTreatQStep]
    //if yes section
    let stopTreatYesID = "stopTreatYesID"
    let stopTreatYesStep = ORKFormStep(identifier: stopTreatYesID)
    stopTreatYesStep.title = "Discontinuation Details"
    
    let stopTreatName = ORKFormItem(identifier: "stopTreatName", text:"Enter name of discontinued treatment(s)", answerFormat: ORKTextAnswerFormat())
    let stopTreatDate = ORKFormItem(identifier: "stopTreatDate", text:"Enter approximate stop date(s)", answerFormat: ORKTextAnswerFormat())
    let stopTreatReason = ORKFormItem(identifier: "stopTreatReason", text:"Reason for discontinuation", answerFormat: ORKTextAnswerFormat())
    
    stopTreatYesStep.formItems = [stopTreatName, stopTreatDate,stopTreatReason]
    steps += [stopTreatYesStep]
    
    let completionStepID = "Completion Step"
    let completionStep = ORKCompletionStep(identifier: completionStepID)
    completionStep.title = "Thank you for completing the survey!"
    
    steps += [completionStep]
    
    let task = ORKNavigableOrderedTask(identifier: "StandardSurveyTask", steps: steps)
    
    let topLevelQuestionIDs = [newTreatQID, changeTreatQID, stopTreatQID]
    
    for (idx,questionID) in topLevelQuestionIDs.enumerated() {
        var nextQID : String
        
        if (idx == topLevelQuestionIDs.count - 1) {
            nextQID = completionStepID
        }
        else {
            nextQID = topLevelQuestionIDs[idx+1]
        }
        //1
        let qPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: questionID), expectedAnswer: false)
        
        //2
        let predicatedNavigationRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(qPredicate, nextQID)], defaultStepIdentifierOrNil: nil)
        
        //3
        task.setNavigationRule(predicatedNavigationRule, forTriggerStepIdentifier: questionID)
        
    }
    
    

    
    //    //1
    //    let directNavigationRule1 = ORKDirectStepNavigationRule(destinationStepIdentifier: completionChoice2ID)
    //    task.setNavigationRule(directNavigationRule1, forTriggerStepIdentifier: question2ID)
    //
    //    //2
    //    let directNavigationRule2 = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    //    task.setNavigationRule(directNavigationRule2, forTriggerStepIdentifier: newTreatDetailsID)
    
    
    return task
}
