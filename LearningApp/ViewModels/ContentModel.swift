//  ContentModel.swift
//  LearningApp

//  Created by Léa Dukaez on 25/08/2021.

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    // Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
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
    
    // MARK: - Lesson navigation methods
    
    func beginLesson(_ lessonIndex: Int) {
        // Check that the lesson index is within range of module lessons
        
        if lessonIndex < currentModule!.content.lessons.count {
                currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
//        setCurrentLesson()
        // Set the current Lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // Set the current Lesson Explanation
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the lesson
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
//        setCurrentLesson()
            
            // Set the current Lesson
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            // Set the current Lesson Explanation
            codeText = addStyling(currentLesson!.explanation)
        } else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    private func setCurrentLesson() {
        // Set the current Lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // Set the current Lesson Explanation
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    
    // MARK: - Test navigation methods
    
    func beginTest(_ moduleId: Int) {
        // set CurrentModule
        beginModule(moduleId)
        
        //Set current question
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that it is within range
        if currentQuestionIndex < currentModule!.test.questions.count {

            // Set the current Question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // Set the current Question details
            codeText = addStyling(currentQuestion!.content)
        } else {
            // Reset the question state
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    func hasNextQuestion() -> Bool {
        return (currentQuestionIndex + 1 < currentModule!.test.questions.count)
    }
    
    
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }

        return resultString
    }
    
}
