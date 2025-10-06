//
//  ContentView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//
/*
 The requirements are:

 - Allow a learner to enter metadata: unique ID, age, gender, school, region.

 - Show at least 3 digitised test questions from the PDFs (with different interaction types: multiple-choice, odd-one-out, numeric input).

 - Provide immediate feedback per question (“Correct” / “Incorrect” + explanation).

 - Store learner metadata, answers, and score locally on the iPad.

 - Export results as a .CSV file that includes learner metadata, answers, and scores.
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LearnerFormView()
        }
    }
}

#Preview {
    ContentView()
}
