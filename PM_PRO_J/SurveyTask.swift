//
//  SurveyTask.swift
//  PM_PRO_2
//
//  Created by Travis Allen on 10/8/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKNavigableOrderedTask {
    
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Standardized Survey"
    instructionStep.text = "Please answer questions with respect to your last completed survey."
    steps += [instructionStep]
    
    //TODO: add name question
    // New treatments
    let newTreat = ORKQuestionStep(identifier: "newTreat")
    newTreat.title = "Have you started any new treatments?"
    newTreat.answerFormat = ORKBooleanAnswerFormat()
    steps += [newTreat]
    
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "Name of the New Treatment"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    
//    let predicate = ORKResultPredicate.predicateForBooleanQuestionResult(
//        with: ORKResultSelector(resultIdentifier: newTreat.identifier), expectedAnswer: true)
//    let rule = ORKPredicateStepNavigationRule(
//        resultPredicatesAndDestinationStepIdentifiers: [(predicate, nameQuestionStep.identifier)])
//
//    task.setNavigationRule(rule, forTriggerStepIdentifier: newTreat.identifier)
    let qolTitle = "How would you rate your overall health since the last survey?"
    let textChoices = [
        ORKTextChoice(text: "0 (Very Poor)", value: 0 as NSNumber),
        ORKTextChoice(text: "1", value: 1 as NSNumber),
        ORKTextChoice(text: "2", value: 2 as NSNumber),
        ORKTextChoice(text: "3", value: 3 as NSNumber),
        ORKTextChoice(text: "4", value: 4 as NSNumber),
        ORKTextChoice(text: "5", value: 5 as NSNumber),
        ORKTextChoice(text: "6", value: 6 as NSNumber),
        ORKTextChoice(text: "7 (Excellent)", value: 7 as NSNumber)
    ]
    let qolAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let qolQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: qolTitle, answer: qolAnswerFormat)
    steps += [qolQuestionStep]
    
    
    let comorbid = ORKQuestionStep(identifier: "comorbid")
    comorbid.title = "Have you been diagnosed with any other medical conditions?"
    comorbid.answerFormat = ORKBooleanAnswerFormat()
    steps += [comorbid]
    
//    let diagDate = ORKQuestionStep(identifier:"diagDate")
//    diagDate.title = "Date of New Diagnosis"
//    diagDate.answerFormat = ORKDateAnswerFormat(initWithStyle: Date)
//    steps += [diagDate]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Survey Complete"
    summaryStep.text = "Thank You"
    steps += [summaryStep]
    
    return ORKNavigableOrderedTask(identifier: "SurveyTask", steps: steps)
}
