//
//  Answer.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import SwiftData

@Model
class Answer {
    var questionText: String
    var response: String
    var isCorrect: Bool
    var explanation: String
    
    init(questionText: String, response: String, isCorrect: Bool, explanation: String) {
        self.questionText = questionText
        self.response = response
        self.isCorrect = isCorrect
        self.explanation = explanation
    }
}

