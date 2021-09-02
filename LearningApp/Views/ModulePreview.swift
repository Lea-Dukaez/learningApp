//
//  ModulePreview.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import SwiftUI

struct ModulePreview: View {
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack {
            RectangleCard()
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                // Image
                Image(image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 116, height: 116)
                
                Spacer()
                
                // Text
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Headline
                    Text(title).bold()
                    
                    // Description
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    // Icons
                    HStack {
                        
                        // Number of lessons/questions
                        HStack {
                            Image(systemName: "book.closed")
                                .frame(width: 15, height: 15)
                            Text(count)
                                .font(.system(size: 10))
                        }
                        
                        Spacer()
                        
                        // Time
                        HStack {
                            Image(systemName: "clock")
                                .frame(width: 15, height: 15)
                            Text(time)
                                .font(.system(size: 10))
                        }
                    }.foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0))
                }.padding(.horizontal, 10)
                
            }.padding()
        }
    }
    
}

struct ModulePreview_Previews: PreviewProvider {
    static var previews: some View {
        
        ModulePreview(image: "swift", title: "Learn Swift", description: "Understand the fundamentals of the Swift programming language.", count: "10 lessons", time: "3 hours")
    }
}
