import SwiftUI

struct QuestionView: View {
    let question: Question
    var onConfirm: (String) -> Void
    var onNext: () -> Void

    @State private var selectedOption: String?
    @State private var numericResponse: String = ""
    @State private var isConfirmed = false
    @State private var feedback: String?

    private var response: String {
        question.type == .numericInput ? numericResponse : (selectedOption ?? "")
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(question.text)
                .font(.headline)
                .multilineTextAlignment(.center)

            VStack(spacing: 15) {
                switch question.type {
                case .multipleChoice, .oddOneOut:
                    ForEach(question.options ?? [], id: \.self) { option in
                        Button(action: {
                            guard !isConfirmed else { return }
                            selectedOption = option
                        }) {
                            Text(option)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonBackgroundColor(for: option))
                                .foregroundColor(.primary)
                                .cornerRadius(8)
                        }
                        .animation(.default, value: isConfirmed)
                    }
                case .numericInput:
                    TextField("Enter answer", text: $numericResponse)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(isConfirmed)
                        .multilineTextAlignment(.center)
                }
            }

            if let feedback = feedback {
                Text(feedback)
                    .foregroundColor(response.lowercased() == question.correctAnswer.lowercased() ? .green : .red)
                    .multilineTextAlignment(.center)
                    .padding(.top)
            }

            Spacer()

            Button(action: {
                if isConfirmed {
                    onNext()
                } else {
                    confirmAnswer()
                }
            }) {
                Text(isConfirmed ? "Next" : "Confirm")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isConfirmButtonDisabled() ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isConfirmButtonDisabled())
        }
        .padding()
    }

    private func buttonBackgroundColor(for option: String) -> Color {
        guard isConfirmed == false else {
            let isCorrect = option.lowercased() == question.correctAnswer.lowercased()
            if option == selectedOption {
                return isCorrect ? .green.opacity(0.5) : .red.opacity(0.5)
            } else if isCorrect {
                return .green.opacity(0.5)
            }
            return Color.gray.opacity(0.2)
        }

        return selectedOption == option ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2)
    }

    private func isConfirmButtonDisabled() -> Bool {
        !isConfirmed && response.isEmpty
    }

    private func confirmAnswer() {
        onConfirm(response)
        let isCorrect = response.lowercased() == question.correctAnswer.lowercased()
        feedback = isCorrect ? "Correct ✅" : "Incorrect ❌\n\(question.explanation)"
        isConfirmed = true
    }
}
