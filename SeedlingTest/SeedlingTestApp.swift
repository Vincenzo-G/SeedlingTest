//
//  SeedlingTestApp.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import SwiftUI
import SwiftData

@main
struct SeedlingTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Learner.self, Answer.self])
        }
    }
}
