//
//  StoreVM.swift
//  FairGoPokies
//
//  Created by Oleksii  on 04.06.2024.
//

import Foundation
import SwiftUI

class StoreViewModel: ObservableObject {
    @AppStorage("balance") var balance: Int = 3
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    
    @AppStorage("koalas") var koalasData: Data?
    @AppStorage("backgrounds") var backgroundsData: Data?
    
    @Published var koalaProducts: [Product] = [
        Product(name: "koala1", isBought: true),
        Product(name: "koala2", isBought: false),
        Product(name: "koala3", isBought: false),
        Product(name: "koala4", isBought: false),
        Product(name: "koala5", isBought: false),
        Product(name: "koala6", isBought: false)
    ] {
        didSet {
            saveKoalas()
        }
    }
    
    @Published var backgroundProducts: [Product] = [
        Product(name: "background1", isBought: true),
        Product(name: "background2", isBought: false),
        Product(name: "background3", isBought: false),
        Product(name: "background4", isBought: false)
    ] {
        didSet {
            saveBackgrounds()
        }
    }
    
    init() {
        loadKoalas()
        loadBackgrounds()
    }
    
    func buyKoala(koala: Product) {
        guard let index = koalaProducts.firstIndex(where: { $0.name == koala.name }) else {
            return
        }
        koalaProducts[index].isBought = true
        saveKoalas()
        balance -= 1000
    }
    
    func buyBackground(background: Product) {
        guard let index = backgroundProducts.firstIndex(where: { $0.name == background.name }) else {
            return
        }
        backgroundProducts[index].isBought = true
        saveBackgrounds()
        balance -= 1000
    }
    
    func saveKoalas() {
        if let encodedKoalas = try? JSONEncoder().encode(koalaProducts) {
            koalasData = encodedKoalas
        }
    }
    
    func loadKoalas() {
        if let koalasData = koalasData,
           let decodedKoalas = try? JSONDecoder().decode([Product].self, from: koalasData) {
            koalaProducts = decodedKoalas
        }
    }
    
    func saveBackgrounds() {
        if let encodedBackgrounds = try? JSONEncoder().encode(backgroundProducts) {
            backgroundsData = encodedBackgrounds
        }
    }
    
    func loadBackgrounds() {
        if let backgroundsData = backgroundsData,
           let decodedBackgrounds = try? JSONDecoder().decode([Product].self, from: backgroundsData) {
            backgroundProducts = decodedBackgrounds
        }
    }
}

struct Product: Codable, Identifiable {
    var id = UUID()
    var name: String
    var isBought: Bool
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
    }
}
