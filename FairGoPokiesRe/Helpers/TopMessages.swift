//
//  TopMessages.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//

import SwiftUI
import SwiftMessages

class TopMessage {
    @MainActor static func show(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.warning, includeHaptic: true)
        view.configureContent(title: "", body: message)
        view.button?.isHidden = true
        view.titleLabel?.textAlignment = .center
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 3)
        
        SwiftMessages.show(config: config, view: view)
    }
}
