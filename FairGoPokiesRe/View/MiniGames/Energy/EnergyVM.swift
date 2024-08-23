//
//  EnergyViewModel.swift
//  FairGoPokies
//
//  Created by Oleksii  on 03.06.2024.
//

import Foundation
import SwiftUI

protocol EnergySceneDelegate: AnyObject {
    
    func restartGamePressed()
    
    func notePressed(note: String)
    
}

class EnergyViewModel: ObservableObject {
    @AppStorage("energy") var energy: Int = 3
    @Published var isGameOver = false
    @Published var isWin = false
    
    weak var delegate: EnergySceneDelegate?
    
    func restart() {
        delegate?.restartGamePressed()
    }
    
    func notePressed(note: String) {
        delegate?.notePressed(note: note)
    }
}

protocol DatabaseService {
    func fetchData(query: String, completion: @escaping (Result<[String], Error>) -> Void)
}
