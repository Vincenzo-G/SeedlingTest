//
//  CSVExporter.swift
//  SeedlingTest
//

import Foundation

class CSVExporter {
    static func exportAll(learners: [Learner]) -> String {
        var csv = "ID,Age,Gender,Region,TestTitle,Programme,Score,Details\n"
        
        for learner in learners {
            guard let test = learner.test else {
                csv.append("\(learner.id),\(learner.age),\(learner.gender),\(learner.region),No Test,No Programme,0/0,\n")
                continue
            }
            
            let answers = learner.answers.filter { $0.question.test.id == test.id }
            let total = answers.count
            let correct = answers.filter { $0.isCorrect }.count
            
            csv.append("\(learner.id),\(learner.age),\(learner.gender),\(learner.region),\(test.title),\(test.programme),\(correct)/\(total),\n")
        }
        
        return csv
    }
}

