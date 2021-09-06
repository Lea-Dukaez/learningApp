//
//  TestView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 03/09/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        // Confirm that currentModule is set
        if model.currentQuestion != nil {
            VStack {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answer
                
                // Button
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            // Test hasn't loaded yet
            // Show progress view
            
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        
        TestView().environmentObject(ContentModel())
    }
}
