//
//  ResultView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @Query var learners: [Learner]   // <-- tutti i learner dal DB
    @State private var exportedCSV = ""
    @State private var showCSV = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test Completed").font(.title)
            
            Button("Export All Results (CSV)") {
                exportedCSV = CSVExporter.exportAll(learners: learners)
                showCSV = true
            }
            
            if showCSV {
                ScrollView {
                    Text(exportedCSV)
                        .font(.system(.footnote, design: .monospaced))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                }
            }
        }
        .padding()
    }
}

