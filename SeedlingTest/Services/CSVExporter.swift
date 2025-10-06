//
//  CSVExporter.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import Foundation

class CSVExporter {
    static func exportAll(learners: [Learner]) -> String {
        var csv = "ID,Age,Gender,Region,Test,Score\n"
        
        for learner in learners {
            // Count correct answers
            let total = learner.answers.count
            let correct = learner.answers.filter { $0.isCorrect }.count
            
            // Assuming all answers belong to the same test (e.g., "Base01")
            let testName = learner.answers.first?.testName ?? "Unknown"
            
            csv.append("#\(learner.learnerID),\(learner.age),\(learner.gender),\(learner.region),\(testName),\(correct)/\(total)\n")
        }
        
        return csv
    }
}
