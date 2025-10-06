//
//  QuestionType.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import Foundation
import SwiftData

enum QuestionType: String, Codable {
    case multipleChoice
    case oddOneOut
    case numericInput
}

@Model
class Question {
    var id: UUID
    var text: String
    var type: QuestionType
    var options: [String]?
    var correctAnswer: String
    var explanation: String

    @Relationship(deleteRule: .cascade) var test: Test // appartiene a un Test

    init(text: String, type: QuestionType, options: [String]? = nil, correctAnswer: String, explanation: String, test: Test) {
        self.id = UUID()
        self.text = text
        self.type = type
        self.options = options
        self.correctAnswer = correctAnswer
        self.explanation = explanation
        self.test = test
    }
}
