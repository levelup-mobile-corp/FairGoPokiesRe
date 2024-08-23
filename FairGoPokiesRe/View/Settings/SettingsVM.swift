//
//  SettingsVM.swift
//  FairGoPokies
//
//  Created by Oleksii  on 31.05.2024.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("account") var account: Bool = false
    @AppStorage("name") var name: String = ""
    @AppStorage("sound") var sound: Bool = true
    @AppStorage("click") var click: Bool = true
    @AppStorage("haptic") var haptic: Bool = true
    @Published var isShowingImagePicker = false
    @Published var selectedPhotoData: Data?
    @Published var selectedImage: UIImage?
    @AppStorage("profileImageData") var profileImageData: Data?
}

class ErrorManager: ObservableObject {
    @Published var errorMessage: String?
    
    func showError(message: String) {
        errorMessage = message
    }
    
    func clearError() {
        errorMessage = nil
    }
}
