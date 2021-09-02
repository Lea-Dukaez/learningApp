//
//  DetailsView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 27/08/2021.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        let ratio: CGFloat = 9/16
        
        GeometryReader { geo in
            VStack {
                if url != nil {
                    VideoPlayer(player: AVPlayer(url: url!)).frame(height: geo.size.width * ratio)
                        .cornerRadius(10)
                }
                
                CodeTextView()
                
                // Show the next lesson button, if there is a next lesson
                if model.hasNextLesson() {
                    
                    Button(action: {
                        model.nextLesson()
                        
                    }, label: {
                        ZStack {
                            RectangleCard(color: Color.green).frame(height:48)
                            
                            Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                                .foregroundColor(.white)
                                .bold()
                        }
                    })
                } else {
                    // Show the complete button
                    Button(action: {
                        
                        // Take the user back to he home view
                        model.currentContentSelected =  nil
                    }, label: {
                        ZStack {
                            RectangleCard(color: Color.green).frame(height:48)

                            Text("Complete")
                                .foregroundColor(.white)
                                .bold()
                        }
                    })
                    
                    
                }
                            
            }
        }.navigationTitle(lesson?.title ?? "").padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {        
        ContentDetailView().environmentObject(ContentModel())
    }
}
