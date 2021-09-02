//
//  ContentPreview.swift
//  LearningApp
//
//  Created by Léa Dukaez on 27/08/2021.
//

import SwiftUI

struct ContentPreview: View {
    
    var lesson: Lesson
    
    var body: some View {
        ZStack {
            RectangleCard()
                .aspectRatio(CGSize(width: 335, height: 75), contentMode: .fit)

            HStack {
                Text("\(lesson.id)")
                    .font(.title2)
                    .padding()

                VStack(alignment: .leading, spacing: 8) {
                    Text(lesson.title).bold()
                    Text("Video - \(lesson.duration)").font(.caption)
                }.padding(.leading, 10)

                Spacer()
            }
        }
    }
}

struct ContentPreview_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = ContentModel()
        
        ContentPreview(lesson: model.modules[0].content.lessons[0])
    }
}
