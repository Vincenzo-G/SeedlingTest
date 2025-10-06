//
//  ResultView.swift
//  SeedlingTest
//
//  Created by Vincenzo Gerelli on 29/09/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    @Query var learners: [Learner]   // tutti i learner dal DB
    @Environment(\.modelContext) private var context
    @State private var exportedCSV = ""
    @State private var showCSV = false
    @State private var showResetConfirmation = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test Completed").font(.title)
            
            Button("Export All Results (CSV)") {
                exportedCSV = CSVExporter.exportAll(learners: learners)
                showCSV = true
            }
            
            Button("Reset All Data") {
                showResetConfirmation = true
            }
            .foregroundColor(.red)
            
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
        .confirmationDialog("Are you sure you want to delete all data?", isPresented: $showResetConfirmation, titleVisibility: .visible) {
            Button("Delete All", role: .destructive) {
                resetAllData()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private func resetAllData() {
        let learnersCopy = learners
        
        for learner in learnersCopy {
            context.delete(learner)
        }
        
        do {
            try context.save()
            exportedCSV = ""
            showCSV = false
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }

}



#Preview {
    ResultView()
}
