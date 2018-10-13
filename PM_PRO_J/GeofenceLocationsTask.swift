import Foundation
import ResearchKit

public var GeofenceLocationsTask: ORKOrderedTask {
    var steps = [ORKStep]()
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Location Collection Task"
    instructionStep.text = "Please enter the address for each of the following locations:"
    steps += [instructionStep]
    
    let homeAddress = ORKQuestionStep(identifier: "homeAddress")
    homeAddress.title = "Please enter your home address"
    homeAddress.answerFormat = ORKLocationAnswerFormat()
    steps += [homeAddress]
    
    let workAddress = ORKQuestionStep(identifier: "workAddress")
    workAddress.title = "Please enter your work address"
    workAddress.answerFormat = ORKLocationAnswerFormat()
    steps += [workAddress]
    
    let hospitalAddress = ORKQuestionStep(identifier: "hospitalAddress")
    hospitalAddress.title = "Please enter address of your primary hospital outside of Weill Cornell"
    hospitalAddress.answerFormat = ORKLocationAnswerFormat()
    steps += [hospitalAddress]
    
    return ORKOrderedTask(identifier: "GeofenceLocationsTask", steps: steps)
}
