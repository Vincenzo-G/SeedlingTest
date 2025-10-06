//
//  Answer.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import SwiftData
import Foundation

@Model
class Answer {
    var id: UUID
    var response: String
    var isCorrect: Bool

    @Relationship var learner: Learner
    @Relationship var question: Question

    init(response: String, isCorrect: Bool, learner: Learner, question: Question) {
        self.id = UUID()
        self.response = response
        self.isCorrect = isCorrect
        self.learner = learner
        self.question = question
    }
}


