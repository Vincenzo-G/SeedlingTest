//
//  CSVExporter.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import Foundation

class CSVExporter {
    static func exportAll(learners: [Learner]) -> String {
        var csv = "LearnerID,Age,Gender,School,Region,Question,Response,Correct,Explanation\n"
        
        for learner in learners {
            for answer in learner.answers {
                csv.append("\(learner.learnerID),\(learner.age),\(learner.gender),\(learner.school),\(learner.region),\"\(answer.questionText)\",\"\(answer.response)\",\(answer.isCorrect),\"\(answer.explanation)\"\n")
            }
        }
        
        return csv
    }
}


