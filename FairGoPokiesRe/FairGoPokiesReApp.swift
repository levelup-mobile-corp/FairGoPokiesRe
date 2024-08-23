//
//  FairGoPokiesReApp.swift
//  FairGoPokiesRe
//
//  Created by Oleksii  on 23.08.2024.
//

import SwiftUI

@main
struct FairGoPokiesReApp: App {
    @AppStorage("brain") var brain: Int = 3
    @AppStorage("food") var food: Int = 3
    @AppStorage("energy") var energy: Int = 3
    var body: some Scene {
        WindowGroup {
            LoaderView().ignoresSafeArea()
                .onAppear {
                    minusStat()
                }
        }
    }
    
    func minusStat() {
            brain -= Int.random(in: 0...brain)
            food -= Int.random(in: 0...food)
            energy -= Int.random(in: 0...energy)
    }
}
