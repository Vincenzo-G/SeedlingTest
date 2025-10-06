//
//  Learner.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import Foundation
import SwiftData

@Model
class Learner {
    var id: UUID
    var age: Int
    var gender: String
    var school: String
    var region: String

    @Relationship(deleteRule: .cascade) var test: Test? // ogni Learner fa un solo Test
    @Relationship(deleteRule: .cascade) var answers: [Answer] = [] // risposte del Learner

    init(age: Int, gender: String, school: String, region: String) {
        self.id = UUID()
        self.age = age
        self.gender = gender
        self.school = school
        self.region = region
    }
}
