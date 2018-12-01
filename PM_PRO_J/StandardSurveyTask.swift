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
    let newTreatQID = "survey.new treatments question"
    let newTreatQStep = ORKQuestionStep(identifier: newTreatQID, title: "Have you started any new treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [newTreatQStep]
    
    //if yes section
    let newTreatDetailsID = "survey.newTreatDetailsID"
    let newTreatDetailsStep = ORKFormStep(identifier: newTreatDetailsID)
    newTreatDetailsStep.title = "New Treatment Details"
    let newTreatName = ORKFormItem(identifier:"survey.newTreatName", text:"Enter Name of Treatment(s)", answerFormat: ORKTextAnswerFormat())
    let newTreatDate = ORKFormItem(identifier:"survey.newTreatDate", text:"Enter Approximate Start Date(s)", answerFormat: ORKTextAnswerFormat())
    newTreatDetailsStep.formItems = [newTreatName, newTreatDate]
    steps += [newTreatDetailsStep]
    
    
    //CHANGE TREATMENTS STEP
    //yes-no
    let changeTreatQID = "survey.change treatments question"
    let changeTreatQStep = ORKQuestionStep(identifier: changeTreatQID, title: "Have you changed any of your treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [changeTreatQStep]
    
    //if yes section
    let changeTreatDetailsID = "survey.changeTreatDetailsID"
    let changeDetailsStep = ORKFormStep(identifier: changeTreatDetailsID)
    changeDetailsStep.title = "Change Treatment Details"
    
    let changeTreatName = ORKFormItem(identifier:"survey.changeTreatName", text:"Enter name of treatment(s) changed", answerFormat: ORKTextAnswerFormat())
    let changeTreatDetails = ORKFormItem(identifier:"survey.changeTreatDetails", text:"Details of treatment modification, inlcuding dose, regimen, etc.", answerFormat: ORKTextAnswerFormat())

    changeDetailsStep.formItems = [changeTreatName, changeTreatDetails]
    
    steps += [changeDetailsStep]
    
    
    //STOP TREATMENTS STEP
    let stopTreatQID = "survey.Stop Treatments Questions"
    let stopTreatQStep = ORKQuestionStep(identifier: stopTreatQID, title: "Have you stopped any of your treatments?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [stopTreatQStep]
    //if yes section
    let stopTreatYesID = "survey.stopTreatYesID"
    let stopTreatYesStep = ORKFormStep(identifier: stopTreatYesID)
    stopTreatYesStep.title = "Discontinuation Details"
    
    let stopTreatName = ORKFormItem(identifier: "survey.stopTreatName", text:"Enter name of discontinued treatment(s)", answerFormat: ORKTextAnswerFormat())
    let stopTreatDate = ORKFormItem(identifier: "survey.stopTreatDate", text:"Enter approximate stop date(s)", answerFormat: ORKTextAnswerFormat())
    let stopTreatReason = ORKFormItem(identifier: "survey.stopTreatReason", text:"Reason for discontinuation", answerFormat: ORKTextAnswerFormat())
    
    stopTreatYesStep.formItems = [stopTreatName, stopTreatDate,stopTreatReason]
    steps += [stopTreatYesStep]
    
    //HOSPITALIZATION STEP
    let hospQID = "survey.HospitalizationQuestion"
    let hospStep = ORKQuestionStep(identifier: hospQID, title: "Have you been hospitalized since your last survey?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [hospStep]
    //if yes section
    let hospYesID = "survey.hospYesID"
    let hospYesStep = ORKFormStep(identifier: hospYesID)
    hospYesStep.title = "Hospitalization Details"
    
    let hospName = ORKFormItem(identifier: "survey.hospName", text:"Name of institution in which you were hospitalized", answerFormat: ORKTextAnswerFormat())

    let hospReason = ORKFormItem(identifier: "survey.hospReason", text:"Reason for hospitalization", answerFormat: ORKTextAnswerFormat())
    
    hospYesStep.formItems = [hospName, hospReason]
    steps += [hospYesStep]
    
    //PROCEDURE STEP
    let procIdentifer = "survey.procIdentifier"
    
    let procedureTextChoices = [
        ORKTextChoice(text: "Scans", value: "Scans" as NSString),
        ORKTextChoice(text: "Biopsy", value: "Biopsy" as NSString),
        ORKTextChoice(text: "Cancer-Related Surgery", value: "Cancer-Related Surgery" as NSString),
        ORKTextChoice(text: "Other surgery", value: "Other surgery" as NSString)
        
    ]
    let procedureAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: procedureTextChoices)
    
    let procStep = ORKFormStep(identifier: procIdentifer)
    let procChoiceItem = ORKFormItem(identifier: "survey.procChoice", text:"Select any of the following surgeries you have undergone", answerFormat: procedureAnswerFormat)
    let procDetailItem = ORKFormItem(identifier: "survey.procDetial", text: "Please provide any known details of the procedure(s), including procedure type, reason, date, location, etc.", answerFormat: ORKTextAnswerFormat())
    procStep.formItems = [procChoiceItem, procDetailItem]
    
    steps += [procStep]
    
    
    //EVENTS STEP
    let eventsIdentifer = "eventsIdentifier"
    
    let eventsTextChoices = [
        ORKTextChoice(text: "Progression of disease", value: "Progression of disease" as NSString),
        ORKTextChoice(text: "Diagnosis of secondary malignancy", value: "Diagnosis of secondary malignancy" as NSString),
        ORKTextChoice(text: "Other significant cancer-related event (ex: PSA rise)", value: "Other significant cancer-related event" as NSString),
        
    ]
    let eventsAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: eventsTextChoices)
    
    let eventsStep = ORKFormStep(identifier: eventsIdentifer)
    let eventsChoiceItem = ORKFormItem(identifier: "survey.eventsChoice", text:"Select any of the following events you have experienced:", answerFormat: eventsAnswerFormat)
    let eventDetailItem = ORKFormItem(identifier: "survey.eventDetail", text: "Please provide any known details of the event(s)", answerFormat: ORKTextAnswerFormat())
    eventsStep.formItems = [eventsChoiceItem, eventDetailItem]
    
    steps += [eventsStep]
    
    //QOL STEP
    
    let qolIdentifier = "survey.qolIdentifier"
    
    let qolStep = ORKQuestionStep(identifier: qolIdentifier)
    qolStep.title = "How would you rate your overall health since the last survey?"
    
    qolStep.answerFormat = ORKScaleAnswerFormat(maximumValue: 7, minimumValue: 1, defaultValue: 4, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Very Poor")
    
    steps += [qolStep]
    
    //TREATING PHYSICIAN STEP
    let treatPhysID = "Treating Physician Question"
    let treatPhysStep = ORKQuestionStep(identifier: treatPhysID, title: "Have there been any changes to your treating physician?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [treatPhysStep]
    //if yes section
    let newPhysYesID = "survey.newPhysYesID"
    let newPhysYesStep = ORKFormStep(identifier: newPhysYesID)
    newPhysYesStep.title = "Please provide any known information about new treating physician"
    
    let newPhysName = ORKFormItem(identifier: "survey.newPhysName", text:"Name:", answerFormat: ORKTextAnswerFormat())
    let newPhysLoc = ORKFormItem(identifier: "survey.newPhysLoc", text:"Institution/Location:", answerFormat: ORKTextAnswerFormat())
    let newPhysContact = ORKFormItem(identifier: "survey.newPhysContact", text:"Contact Information", answerFormat: ORKTextAnswerFormat())
    
    newPhysYesStep.formItems = [newPhysName, newPhysLoc,newPhysContact]
    steps += [newPhysYesStep]
    
    //CO-MORBIDITIES STEP
    let comorbidID = "survey.Comorbidities Question"
    let comorbidStep = ORKQuestionStep(identifier: comorbidID, title: "Have you been diagnosed with any other medical conditions?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [comorbidStep]
    //if yes section
    let comorbidYesID = "survey.comorbidYesID"
    let comorbidYesStep = ORKFormStep(identifier: comorbidYesID)
    comorbidYesStep.title = "Please provide any known details of condition, including diagnosis, date of diagnosis, and any treatment received."
    
    let comborbidDetail = ORKFormItem(identifier: "survey.comborbidDetail", text:"Details", answerFormat: ORKTextAnswerFormat())
    
    comorbidYesStep.formItems = [comborbidDetail]
    steps += [comorbidYesStep]
    
    //FAM HISTORY STEP
    let famHistID = "survey.Family History Question"
    let famHistStep = ORKQuestionStep(identifier: famHistID, title: "Have any of your family members been newly diagnosed with cancer?", answer: ORKAnswerFormat.booleanAnswerFormat())
    steps += [famHistStep]
    //if yes section
    let famHistYesID = "survey.famHistYesID"
    let famHistYesStep = ORKFormStep(identifier: famHistYesID)
    comorbidYesStep.title = "Please provide any known details of the diagnosis"
    
    let famHistDetail = ORKFormItem(identifier: "survey.famHistDetail", text:"Details", answerFormat: ORKTextAnswerFormat())
    
    famHistYesStep.formItems = [famHistDetail]
    steps += [famHistYesStep]
    
    //COMPLETION STEP
    let completionStepID = "Completion Step"
    let completionStep = ORKCompletionStep(identifier: completionStepID)
    completionStep.title = "Thank you for completing the survey!"
    
    steps += [completionStep]
    
    let task = ORKNavigableOrderedTask(identifier: "StandardSurveyTask", steps: steps)
    
    // Set the predicate rules
    let topLevelQuestionIDs = [newTreatQID, changeTreatQID, stopTreatQID, hospQID, procIdentifer, eventsIdentifer, qolIdentifier, treatPhysID, comorbidID, famHistID]
    
    for (idx,questionID) in topLevelQuestionIDs.enumerated() {
        var nextQID : String
        
        if (idx == topLevelQuestionIDs.count - 1) {
            nextQID = completionStepID
        }
        else if (questionID == procIdentifer || questionID == eventsIdentifer || questionID == qolIdentifier) {
            continue
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
    
    return task
}
