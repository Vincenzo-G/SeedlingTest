//
//  DataStore.swift
//  SeedlingTest
//

import SwiftUI
import SwiftData
import Combine

class DataStore: ObservableObject {
    static let shared = DataStore()
    
    @Published var test: Test
    
    private init() {
        // Creiamo il Test principale
        let baseTest = Test(title: "Baseline001", programme: "Coding & Robotics")
        
        // Creiamo le domande del Test usando QuestionType
        let questions = [
            Question(
                text: "Which word has the 'a' sound?",
                type: .multipleChoice,
                options: ["Cat", "Dog", "Fish"],
                correctAnswer: "Cat",
                explanation: "Cat contains the 'a' sound.",
                test: baseTest
            ),
            Question(
                text: "Circle the odd one out",
                type: .oddOneOut,
                options: ["Apple", "Banana", "Car"],
                correctAnswer: "Car",
                explanation: "Car is not a fruit.",
                test: baseTest
            ),
            Question(
                text: "What is 2 + 3?",
                type: .numericInput,
                options: nil,
                correctAnswer: "5",
                explanation: "2 + 3 = 5",
                test: baseTest
            )
        ]
        
        // Aggiungiamo le domande al Test
        baseTest.questions.append(contentsOf: questions)
        self.test = baseTest
    }
    
    // Registra la risposta di un Learner ad una Question
    func recordAnswer(
        question: Question,
        response: String,
        learner: Learner,
        context: ModelContext
    ) {
        // Controllo correttezza
        let isCorrect = question.correctAnswer.lowercased() == response.lowercased()
        
        // Creo l'Answer
        let answer = Answer(
            response: response,
            isCorrect: isCorrect,
            learner: learner,
            question: question
        )
        
        // Aggiungo l'Answer al Learner
        learner.answers.append(answer)
        
        // Inserisco nel context
        context.insert(answer)
        context.insert(learner)
        context.insert(question.test)
        
        // Salvo
        try? context.save()
    }
    
    /// Restituisce tutte le domande del Test
    func getQuestions() -> [Question] {
        return test.questions
    }
}
