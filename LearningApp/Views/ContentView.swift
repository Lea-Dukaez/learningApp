//
//  LessonsView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {

        ScrollView {
            LazyVStack {
                
                // Confirm that currentModule is set
                if model.currentModule != nil {
                    
                    ForEach(model.currentModule!.content.lessons) { lesson in
                        NavigationLink(
                            destination: DetailsView(lesson: lesson),
                            label: {
                                ContentPreview(lesson: lesson)
                            })
                    }.padding(.horizontal).padding(.top, 10).accentColor(.black)
                    
                }
            }
        }.navigationTitle("Learn \(model.currentModule?.category ?? "")")
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView().environmentObject(ContentModel())
    }
}
