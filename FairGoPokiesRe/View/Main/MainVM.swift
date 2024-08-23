//
//  MainVM.swift
//  FairGoPokies
//
//  Created by Oleksii  on 31.05.2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @AppStorage("brain") var brain: Int = 3
    @AppStorage("food") var food: Int = 3
    @AppStorage("energy") var energy: Int = 3
    
//    init() {
//        brain -= Int.random(in: 0...brain)
//        food -= Int.random(in: 0...food)
//        energy -= Int.random(in: 0...energy)
//        print("dula")
//    }
}

protocol DataLoader {
    func fetchData(completion: @escaping (Result<String, Error>) -> Void)
}
