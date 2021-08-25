//
//  ContentModel.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getDataModules()
    }
    
    func getDataModules() {
        
        let url = Bundle.main.url(forResource: "data", withExtension: "json")
        
        guard url != nil else {
            print("Couldn't find data.json")
            return
        }

        do {
            let safeData = try Data(contentsOf: url!)
            
            let decoder = JSONDecoder()
            
            do {
                let dataModules = try decoder.decode([Module].self, from: safeData)
                
                self.modules = dataModules
            } catch {
                print("Couldn't decode data", error)
            }
        } catch {
            print("Couldn't get data", error)
        }
        
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        guard styleUrl != nil else {
            print("Couldn't find style.html")
            return
        }
        
        do {
            let safeStyleData  = try Data(contentsOf: styleUrl!)
            self.styleData = safeStyleData
        
        } catch {
            print("Couldn't get data", error)
        }
        
    }
}
