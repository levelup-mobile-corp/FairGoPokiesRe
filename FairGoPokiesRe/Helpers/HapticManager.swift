//
//  HapticManager.swift
//  FairGoPokiesRe
//
//  Created by Oleksii  on 23.08.2024.
//

import Foundation
import UIKit
import SwiftUI

class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()
    
    @AppStorage("haptic") private var haptic: Bool = true
    
    private init() {}
    
    func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if haptic {
            print("haptic")
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
        } else {
            print("haptic no")
        }
    }
}
