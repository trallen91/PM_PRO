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
    
    //Get day of week and time for BIWEEKLY Standardized Survey
//    let standardSurveyTime = ORKQuestionStep(identifier: "standardSurveyTime")
//    standardSurveyTime.title = "Please enter a day of the week and a time"
//    standardSurveyTime.text = "This survey is taken biweekly.  Select the ideal day and time to be notified to take this survey."
//    standardSurveyTime.answerFormat = ORKLocationAnswerFormat()
//    steps += [standardSurveyTime]
    
    //Get day of week and time for this WEEKLY patient-reported wellbeing survey
    let wellBeingSurveyTime = ORKQuestionStep(identifier: "wellBeingSurveyTime")
    wellBeingSurveyTime.title = "Please enter a day of the week"
    wellBeingSurveyTime.text = "This survey is taken once weekly.  Select the ideal day and time to take this survey"
    wellBeingSurveyTime.answerFormat = ORKLocationAnswerFormat()
    steps += [wellBeingSurveyTime]
    
    //Get time for this DAILY patient-reported side effects survey
    let sideEffectsSurveyTime = ORKQuestionStep(identifier: "sideEffectsSurveyTime")
    sideEffectsSurveyTime.title = "This survey is taken daily.  Select the ideal day and time to take it"
    sideEffectsSurveyTime.answerFormat = ORKLocationAnswerFormat()
    steps += [sideEffectsSurveyTime]
    
    

    

//    let weekdayTitle = "Enter a day of the week"
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
    
    let standardSurveyTimeStep = ORKFormStep(identifier: "standardSurveyTime")
    standardSurveyTimeStep.title = "Standardized Survey Notification Time"
    standardSurveyTimeStep.text = "This survey is taken biweekly.  Select the ideal day and time to be notified to take this survey."
    
    
    let ssWeekday = ORKFormItem(identifier:"ssWeekday", text:"Enter day of week", answerFormat: weekdayAnswerFormat)
    
    standardSurveyTimeStep.formItems = [ssWeekday]
    
//    ssWeekday.answerFormat = weekdayAnswerFormat
//    ssWeekday.
    
     steps += [standardSurveyTimeStep]
    
//    ORKFormStep *step =
//        [[ORKFormStep alloc] initWithIdentifier:kFormIdentifier
//            title:@"Form"
//            text:@"Form groups multi-entry in one page"];
//    NSMutableArray *items = [NSMutableArray new];
//    ORKAnswerFormat *genderFormat =
//        [ORKHealthKitCharacteristicTypeAnswerFormat
//            answerFormatWithCharacteristicType:
//            [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex]];
//    [items addObject:
//        [[ORKFormItem alloc] initWithIdentifier:kGenderItemIdentifier
//        text:@"Gender"
//        answerFormat:genderFormat];
//
//        // Include a section separator
//        [items addObject:
//        [[ORKFormItem alloc] initWithSectionTitle:@"Basic Information"]];
//
//        ORKAnswerFormat *bloodTypeFormat =
//        [ORKHealthKitCharacteristicTypeAnswerFormat
//        answerFormatWithCharacteristicType:
//        [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType]];
//        [items addObject:
//        [[ORKFormItem alloc] initWithIdentifier:kBloodTypeItemIdentifier
//        text:@"Blood Type"
//        answerFormat:bloodTypeFormat]];
//
//        ORKAnswerFormat *dateOfBirthFormat =
//        [ORKHealthKitCharacteristicTypeAnswerFormat
//        answerFormatWithCharacteristicType:
//        [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth]];
//        ORKFormItem *dateOfBirthItem =
//        [[ORKFormItem alloc] initWithIdentifier:kDateOfBirthItemIdentifier
//        text:@"DOB"
//        answerFormat:dateOfBirthFormat]];
//    dateOfBirthItem.placeholder = @"DOB";
//    dateOfBirthItem.optional = YES;
//    [items addObject:dateOfBirthItem];
//
//    // ... And so on, adding additional items
//    step.formItems = items;
    
    return ORKOrderedTask(identifier: "SetSurveyTimeTask", steps: steps)
}
