import SwiftUI
import SwiftData

struct TestView: View {
    @Environment(\.modelContext) var context
    
    var learner: Learner
    @State private var currentIndex = 0
    @State private var navigateToResults = false
    
    private var questions: [Question] {
        learner.test?.questions ?? []
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if currentIndex < questions.count {
                    let question = questions[currentIndex]
                    QuestionView(
                        question: question,
                        onConfirm: { response in
                            recordAnswer(question: question, response: response)
                        },
                        onNext: {
                            goToNextQuestion()
                        }
                    )
                    .id(question.id)
                }
            }
            .navigationDestination(isPresented: $navigateToResults) {
                ResultView()
            }
        }
    }
    
    private func recordAnswer(question: Question, response: String) {
        let isCorrect = response.lowercased() == question.correctAnswer.lowercased()
        let answer = Answer(
            response: response,
            isCorrect: isCorrect,
            learner: learner,
            question: question
        )
        learner.answers.append(answer)
        context.insert(answer)
        context.insert(learner)
        try? context.save()
    }
    
    private func goToNextQuestion() {
        let nextIndex = currentIndex + 1
        if nextIndex < questions.count {
            currentIndex = nextIndex
        } else {
            navigateToResults = true
        }
    }
}
