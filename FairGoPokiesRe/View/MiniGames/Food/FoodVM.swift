//
//  FoodVM.swift
//  FairGoPokies
//
//  Created by Oleksii  on 04.06.2024.
//

import Foundation
import SwiftUI

class FoodViewModel: ObservableObject {
    @AppStorage("food") var food: Int = 3
    @Published var isWin: Bool = false
    @Published var isGameOver: Bool = false
}

class ImageLoaders: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }
    }
}
