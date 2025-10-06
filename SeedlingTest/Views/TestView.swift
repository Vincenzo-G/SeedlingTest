//
//  TestView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import SwiftUI
import SwiftData

struct TestView: View {
    @ObservedObject var store = DataStore.shared
    @Environment(\.modelContext) private var context
    
    var learner: Learner
    @State private var currentIndex = 0
    @State private var navigateToResults = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if currentIndex < store.questions.count {
                    QuestionView(question: store.questions[currentIndex]) { response in
                        store.recordAnswer(
                            question: store.questions[currentIndex],
                            response: response,
                            learner: learner,
                            context: context
                        )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            currentIndex += 1
                            if currentIndex >= store.questions.count {
                                navigateToResults = true
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToResults) {
                ResultView()
            }
        }
    }
}


