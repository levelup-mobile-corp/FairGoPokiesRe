//
//  Colors.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
//    static let lightGreen = Color(hex: "E8FBEB")
//    static let blackGreen = Color(hex: "032119")
    static let yellowGradient = LinearGradient(colors: [Color(hex: "FFDB22"), Color(hex: "F1F6E3")], startPoint: .leading, endPoint: .trailing)
    static let blueGradient = LinearGradient(colors: [Color(hex: "5B22FF"), Color(hex: "D22ACB")], startPoint: .leading, endPoint: .trailing)
    static let greenGradient = LinearGradient(colors: [Color(hex: "247217"), Color(hex: "20D710"), Color(hex: "20D710"), Color(hex: "247217")], startPoint: .top, endPoint: .bottom)
    static let lightBlueGradient = LinearGradient(colors: [Color(hex: "78B3FA"), Color(hex: "112B4C")], startPoint: .leading, endPoint: .trailing)
}
