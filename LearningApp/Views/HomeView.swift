//
//  ContentView.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        

        NavigationView {
            VStack(alignment: .leading) {
                Text("What would you like to do today?").padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in

                            VStack(alignment: .center, spacing: 30) {
                                
                                // Content "Learn"
                                NavigationLink(
                                    destination: ContentView().onAppear(perform: {
                                        model.beginModule(module.id)
                                    }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    label: {
                                        ModulePreview(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time).accentColor(.black)
                                })

                                // Test
                                NavigationLink(
                                    destination: TestView().onAppear(perform: {
                                        model.beginTest(module.id)
                                    }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    label: {
                                        ModulePreview(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time).accentColor(.black)
                                })
                                
                                NavigationLink(
                                    destination: EmptyView() ) {
                                        EmptyView()
                                    }
                                
                            }
                        }.padding()
                    }
                }.navigationTitle("Get Started")
            }
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
