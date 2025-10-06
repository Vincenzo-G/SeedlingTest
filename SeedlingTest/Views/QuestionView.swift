//
//  QuestionView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//
import SwiftUI

struct QuestionView: View {
    let question: Question
    var onAnswer: (String) -> Void
    
    @State private var response = ""
    @State private var feedback: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question.text).font(.headline)
            
            switch question.type {
            case .multipleChoice, .oddOneOut:
                ForEach(question.options ?? [], id: \.self) { option in
                    Button(option) {
                        response = option
                        checkAnswer()
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                }
            case .numericInput:
                TextField("Enter answer", text: $response)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Submit") {
                    checkAnswer()
                }
            }
            
            if let feedback = feedback {
                Text(feedback).foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    private func checkAnswer() {
        onAnswer(response)
        let isCorrect = response.lowercased() == question.correctAnswer.lowercased()
        feedback = isCorrect ? "Correct ✅" : "Incorrect ❌\n\(question.explanation)"
    }
}

