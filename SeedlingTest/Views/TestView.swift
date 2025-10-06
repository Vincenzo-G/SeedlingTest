import SwiftUI
import SwiftData

struct TestView: View {
    @ObservedObject var store = DataStore.shared
    @Environment(\.modelContext) var context
    
    var learner: Learner
    @State private var currentIndex = 0
    @State private var navigateToResults = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if currentIndex < store.questions.count {
                    QuestionView(
                        question: store.questions[currentIndex],
                        onConfirm: { response in
                            store.recordAnswer(
                                question: store.questions[currentIndex],
                                response: response,
                                learner: learner,
                                context: context
                            )
                        },
                        onNext: {
                            goToNextQuestion()
                        }
                    )
                    .id(store.questions[currentIndex].id)
                }
            }
            .navigationDestination(isPresented: $navigateToResults) {
                ResultView()
            }
        }
    }
    
    func goToNextQuestion() {
        let nextIndex = currentIndex + 1
        if nextIndex < store.questions.count {
            currentIndex = nextIndex
        } else {
            navigateToResults = true
        }
    }
}