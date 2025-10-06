//
//  QuestionType.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import Foundation

enum QuestionType: String, Codable {
    case multipleChoice
    case oddOneOut
    case numericInput
}

struct Question: Identifiable, Codable {
    let id: UUID
    let text: String
    let type: QuestionType
    let options: [String]?
    let correctAnswer: String
    let explanation: String
}


