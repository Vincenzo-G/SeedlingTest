//
//  Learner.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//


import SwiftData
import Foundation

@Model
class Learner {
    @Attribute(.unique) var learnerID: String
    var age: Int
    var gender: String
    var school: String
    var region: String
    @Relationship(deleteRule: .cascade) var answers: [Answer] = []

    init(age: Int, gender: String, school: String, region: String) {
        self.learnerID = UUID().uuidString
        self.age = age
        self.gender = gender
        self.school = school
        self.region = region
    }
}


