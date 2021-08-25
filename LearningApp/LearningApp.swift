//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
