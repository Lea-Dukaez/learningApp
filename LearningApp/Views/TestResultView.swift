//
//  TestResultView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 07/09/2021.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numCorrect: Int
    
    var resultHeading:String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let percent = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        if percent > 0.5 {
            return "Awesome !"
        } else if percent > 0.2 {
            return "Doing Great !"
        } else {
            return "Keep learning."
        }
    }
    var body: some View {
        
        VStack {
            Spacer()
            Text(resultHeading).font(.title)
            Spacer()
            Text("You got \(numCorrect) ou of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            Button(action: {
                
                // Send the user back to the home view
                model.currentTestSelected = nil
                
            }, label: {
                ZStack {
                    RectangleCard(color: .green).frame(height: 48)
                    Text("Complete").bold().foregroundColor(.white)
                }
            }).padding()
            Spacer()
        }

    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView(numCorrect: 2).environmentObject(ContentModel())
    }
}
