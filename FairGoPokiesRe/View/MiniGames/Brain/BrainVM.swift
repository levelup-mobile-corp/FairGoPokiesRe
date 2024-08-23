//
//  BrainVM.swift
//  FairGoPokies
//
//  Created by Oleksii  on 03.06.2024.
//

import Foundation
import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
}

class QuizViewModel: ObservableObject {
    @AppStorage("brain") var brain: Int = 3
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswerIndex: Int?
    @Published var isGameOver: Bool = false
    @Published var isKoalaMode: Bool = false
    @AppStorage("name") var name: String = ""
    @Published var koalaText: String = "Go"
    
    @Published var brains: Int = 0
    
    var questions: [Question] = [
        Question(text: "What is a group of koalas called?", options: ["Herd", "Pack", "Colony", "Flock"], correctAnswerIndex: 2),
        Question(text: "How many hours per day do koalas sleep on average?", options: ["8-10 hours", "12-14 hours", "16-18 hours", "20-22 hours"], correctAnswerIndex: 1),
        Question(text: "What is the primary diet of koalas?", options: ["Insects", "Grass", "Leaves of the eucalyptus tree", "Fish"], correctAnswerIndex: 2),
        Question(text: "Where are koalas native to?", options: ["Australia", "Africa", "South America", "Europe"], correctAnswerIndex: 0),
        Question(text: "How many fingers do koalas have on each hand?", options: ["3", "4", "5", "6"], correctAnswerIndex: 1),
        Question(text: "What is the average lifespan of a koala in the wild?", options: ["5-7 years", "10-12 years", "15-18 years", "20-22 years"], correctAnswerIndex: 1),
        Question(text: "What is the scientific name for koalas?", options: ["Phascolarctos cinereus", "Ursus arctos", "Panthera leo", "Canis lupus"], correctAnswerIndex: 0),
        Question(text: "How do koalas primarily communicate?", options: ["Vocalizations", "Visual signals", "Chemical signals", "Telepathy"], correctAnswerIndex: 2),
        Question(text: "How fast can koalas run?", options: ["5 mph (8 km/h)", "10 mph (16 km/h)", "15 mph (24 km/h)", "20 mph (32 km/h)"], correctAnswerIndex: 0),
        Question(text: "How many species of eucalyptus do koalas eat?", options: ["Less than 10", "Around 50", "More than 100", "Over 600"], correctAnswerIndex: 2),
        Question(text: "What is the gestation period of koalas?", options: ["1-2 months", "3-4 months", "5-6 months", "7-8 months"], correctAnswerIndex: 3),
        Question(text: "What is the primary threat to koala populations in the wild?", options: ["Deforestation", "Pollution", "Hunting", "Climate change"], correctAnswerIndex: 0),
        Question(text: "How many koalas are estimated to be left in the wild?", options: ["Less than 10,000", "Around 50,000", "More than 100,000", "Over 1 million"], correctAnswerIndex: 1),
        Question(text: "What is the average weight of an adult koala?", options: ["5-10 pounds (2-4.5 kg)", "10-15 pounds (4.5-7 kg)", "15-20 pounds (7-9 kg)", "20-25 pounds (9-11 kg)"], correctAnswerIndex: 0),
        Question(text: "What is the conservation status of koalas according to the IUCN Red List?", options: ["Least Concern", "Near Threatened", "Vulnerable", "Endangered"], correctAnswerIndex: 3)
    ]
    
    init() {
        brains = brain
        questions.shuffle()
    }
    
    func submitAnswer(index: Int) {
            selectedAnswerIndex = index
            if index == questions[currentQuestionIndex].correctAnswerIndex {
                brains += 1
                koalaText = "Hooray!"
                if brain > 7 {
                    withAnimation(.easeInOut) {
                        isGameOver = true
                    }
                }
            } else {
                koalaText = ": ("
            }
    }
    
    func goToNextQuestion() {
        koalaText = "Go"
        selectedAnswerIndex = nil
        currentQuestionIndex = Int.random(in: 0...14)
    }
    
    func getRandomQuestion() -> Question {
        return questions[currentQuestionIndex]
    }
    
    func koalaAnswer() {
        koalaText = "hmm"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.isKoalaMode {
                self.selectedAnswerIndex = Int.random(in: 0..<self.questions[self.currentQuestionIndex].options.count)
                self.submitAnswer(index: self.selectedAnswerIndex!)
            }
        }
    }
}

protocol DataSaver {
    func saveData<T: Encodable>(_ data: T, to fileName: String) throws
}
