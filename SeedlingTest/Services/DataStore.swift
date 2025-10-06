//
//  DataStore.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import SwiftUI
import SwiftData
import Combine

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    @Published var questions: [Question] = []
    
    private init() {
        questions = [
            Question(
                id: UUID(),
                text: "Which word has the 'a' sound?",
                type: .multipleChoice,
                options: ["Cat", "Dog", "Fish"],
                correctAnswer: "Cat",
                explanation: "Cat contains the 'a' sound."
            ),
            Question(
                id: UUID(),
                text: "Circle the odd one out",
                type: .oddOneOut,
                options: ["Apple", "Banana", "Car"],
                correctAnswer: "Car",
                explanation: "Car is not a fruit."
            ),
            Question(
                id: UUID(),
                text: "What is 2 + 3?",
                type: .numericInput,
                options: nil,
                correctAnswer: "5",
                explanation: "2 + 3 = 5"
            )
        ]
    }
    
    func recordAnswer(
        question: Question,
        response: String,
        learner: Learner,
        context: ModelContext
    ) {
        let isCorrect = response.lowercased() == question.correctAnswer.lowercased()
        let answer = Answer(
            questionText: question.text,
            response: response,
            isCorrect: isCorrect,
            explanation: question.explanation
        )
        learner.answers.append(answer)
        
        context.insert(answer)
        context.insert(learner)
        try? context.save()
    }
}
