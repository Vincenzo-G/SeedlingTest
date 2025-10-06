import SwiftUI
import SwiftData

struct LearnerFormView: View {
    @Environment(\.modelContext) private var context
    @State private var age = ""
    @State private var gender = ""
    @State private var school = ""
    @State private var region = ""
    
    // Lista di Test disponibili
    @State private var selectedTest: Test? = nil
    @State private var availableTests: [Test] = [DataStore.shared.test] // Puoi aggiungere altri Test qui
    
    @State private var navigateToTest = false
    @State private var learner: Learner? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Learner Information")) {
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Gender", text: $gender)
                    TextField("School", text: $school)
                    TextField("Region", text: $region)
                }
                
                Section(header: Text("Select Test")) {
                    Picker("Test", selection: $selectedTest) {
                        ForEach(availableTests, id: \.id) { test in
                            Text(test.title).tag(Optional(test))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Button("Start Test") {
                    guard let test = selectedTest else { return }
                    
                    let newLearner = Learner(
                        age: Int(age) ?? 0,
                        gender: gender,
                        school: school,
                        region: region
                    )
                    
                    // Assegna il test selezionato
                    newLearner.test = test
                    
                    context.insert(newLearner)
                    
                    self.learner = newLearner
                    navigateToTest = true
                }
                .disabled(age.isEmpty || gender.isEmpty || selectedTest == nil)
            }
            .navigationTitle("New Learner")
            .navigationDestination(isPresented: $navigateToTest) {
                if let learner = learner {
                    TestView(learner: learner)
                }
            }
        }
    }
}

