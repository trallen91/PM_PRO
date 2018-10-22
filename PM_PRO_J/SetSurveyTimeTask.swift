//
//  SetSurveyTimeTask.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/21/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import Foundation
import ResearchKit

public var SetSurveyTimeTask: ORKOrderedTask {
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Set Survey Times"
    instructionStep.text = "Please enter the preferred times you'd like to receive notifications for the surveys involved in this study"
    steps += [instructionStep]
    
    //These answer formats will be used across all 3 steps
    let weekdayTextChoices = [
        ORKTextChoice(text: "Monday", value: "Monday" as NSString),
        ORKTextChoice(text: "Tuesday", value: "Tuesday" as NSString),
        ORKTextChoice(text: "Wednesday", value: "Wednesday" as NSString),
        ORKTextChoice(text: "Thursday", value: "Thursday" as NSString),
        ORKTextChoice(text: "Friday", value: "Friday" as NSString),
        ORKTextChoice(text: "Saturday", value: "Saturday" as NSString),
        ORKTextChoice(text: "Sunday", value: "Sunday" as NSString)
        
    ]
    let weekdayAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: weekdayTextChoices)
    let timeAnswerFormat: ORKTimeOfDayAnswerFormat = ORKTimeOfDayAnswerFormat()
    
    
    //Standard Survey is a bi-weekly survey
    let standardSurveyTimeStep = ORKFormStep(identifier: "standardSurveyTime")
    standardSurveyTimeStep.title = "Standardized Survey"
    standardSurveyTimeStep.text = "Please select the ideal day and time to take this BI-WEEKLY survey."
    
    let ssWeekday = ORKFormItem(identifier:"ssWeekday", text:"Enter day of week", answerFormat: weekdayAnswerFormat)
    let ssTime = ORKFormItem(identifier:"ssTime", text:"Enter time of day", answerFormat: timeAnswerFormat)
    standardSurveyTimeStep.formItems = [ssTime, ssWeekday]
    
     steps += [standardSurveyTimeStep]
    
    
    //Get day of week and time for this WEEKLY patient-reported wellbeing survey
    let wellBeingSurveyTime = ORKFormStep(identifier: "wellBeingSurveyTime")
    wellBeingSurveyTime.title = "Well-Being Survey"
    wellBeingSurveyTime.text = "Place select the ideal day and time to take this WEEKLY survey"
    
    let wbWeekday = ORKFormItem(identifier: "wbWeekday", text: "Enter day of week", answerFormat: weekdayAnswerFormat)
    let wbTime = ORKFormItem(identifier: "wbTime", text:"Enter time of day", answerFormat: timeAnswerFormat)
    
    wellBeingSurveyTime.formItems = [wbTime, wbWeekday]
    
    steps += [wellBeingSurveyTime]
    
    //Get time for this DAILY patient-reported side effects survey
    let sideEffectsSurveyTime = ORKQuestionStep(identifier: "sideEffectsSurveyTime")
    sideEffectsSurveyTime.title = "Side Effects Survey"
    sideEffectsSurveyTime.text = "Please enter the ideal time of day for you to take this DAILY survey"
    sideEffectsSurveyTime.answerFormat = timeAnswerFormat
    steps += [sideEffectsSurveyTime]
    
    
    return ORKOrderedTask(identifier: "SetSurveyTimeTask", steps: steps)
}
