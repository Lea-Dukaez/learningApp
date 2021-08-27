//
//  ContentModel.swift
//  LearningApp
//
//  Created by Léa Dukaez on 25/08/2021.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init() {
        getDataModules()
    }
    
    // MARK: - Data Methods
    
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


    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId: Int) {
        // Find the index for the module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
}
