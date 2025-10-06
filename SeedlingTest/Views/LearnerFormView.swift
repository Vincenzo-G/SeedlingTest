//
//  LearnerFormView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import SwiftUI
import SwiftData

struct LearnerFormView: View {
    @Environment(\.modelContext) private var context
    @State private var learnerID = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var school = ""
    @State private var region = ""
    
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
                
                Button("Start Test") {
                    let learner = Learner(
                        age: Int(age) ?? 0,
                        gender: gender,
                        school: school,
                        region: region
                    )
                    context.insert(learner)
                    
                    self.learner = learner
                    navigateToTest = true
                }
                .disabled(age.isEmpty || gender.isEmpty)
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


