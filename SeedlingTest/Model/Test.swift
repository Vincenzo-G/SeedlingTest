//
//  Untitled.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 06/10/25.
//

import Foundation
import SwiftData

@Model
class Test {
    var id: UUID
    var title: String
    var programme: String

    @Relationship(deleteRule: .cascade) var questions: [Question] = [] // il test contiene più domande

    init(title: String, programme: String) {
        self.id = UUID()
        self.title = title
        self.programme = programme
    }
}

