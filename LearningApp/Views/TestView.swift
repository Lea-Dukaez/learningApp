//
//  TestView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 03/09/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel

    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false

    

    
    var body: some View {
        
        // Confirm that currentModule is set
        if model.currentQuestion != nil {
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView().padding(.horizontal, 20)
                
                // Answer
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id:\.self) { index in
                            
                                Button(action: {
                                    // track selected index
                                    selectedAnswerIndex = index
                                    
                                }, label: {
                                    
                                    ZStack {
                                        if submitted == false {
                                            RectangleCard(color: index == selectedAnswerIndex ? Color.gray : Color.white).frame(height: 48)
                                        } else {
                                            
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.green).frame(height: 48)
                                            } else  if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.red).frame(height: 48)
                                            } else  if index == model.currentQuestion!.correctIndex {
                                                RectangleCard(color: Color.green).frame(height: 48)
                                            } else {
                                                RectangleCard().frame(height: 48)
                                            }
                                            
                                            
                                        }
                                        
                                        Text(model.currentQuestion!.answers[index]).foregroundColor(index == selectedAnswerIndex ? Color.white : Color.black).bold()
                                    }
                                }).disabled(submitted)
                        }
                    }.padding()
                }
                
                
                // Button
                Button(action: {
                    
                    // Check if answer has been sbmitted
                    if submitted {

                        model.nextQuestion()
                        
                        // Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
 
                    } else {
                        // Submit the answer
                        
                        // Change submitted state to true
                        submitted = true
                        
                        // Check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                }, label: {
                    ZStack {
                        RectangleCard(color: Color.green).frame(height: 48)
                        Text(buttonText).bold()
                    }.accentColor(.white)
                    .padding()
                }).disabled(selectedAnswerIndex == nil)
                
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            // Test hasn't loaded yet
            // Show progress view
//            if goToTestResult {
//                goToTestResult = false
//                TestResultView(numCorrect: numCorrect)
//            } else {
//                ProgressView()
//            }

            TestResultView(numCorrect: numCorrect)
            
        }
    }
    
    var buttonText:String {
        // Check if answer has been submitted
        if submitted {
            if model.isLastQuestion() {
                return "Finish"
            } else {
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        
        TestView().environmentObject(ContentModel())
    }
}
