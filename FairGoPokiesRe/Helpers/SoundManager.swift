//
//  SoundManager.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//


import AVFoundation
import Foundation
import SwiftUI

class SoundManager {
    static let shared = SoundManager()
    
    private var backgroundAudioPlayer: AVAudioPlayer?
    private var buttonAudioPlayer: AVAudioPlayer?
    
    @AppStorage("sound") private var sound: Bool = true
    @AppStorage("click") private var click: Bool = true
    
    private init() {}
    
    func playBackgroundMusic() {
        if sound {
            guard let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "wav") else {
                print("File not found")
                return
            }
            
            do {
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundAudioPlayer?.numberOfLoops = -1
                backgroundAudioPlayer?.play()
            } catch {
                print("Could not play background music: \(error.localizedDescription)")
            }
        }
    }
    
    func playClick() {
        if click {
            guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else {
                print("File not found")
                return
            }
            
            do {
                buttonAudioPlayer = try AVAudioPlayer(contentsOf: url)
                buttonAudioPlayer?.numberOfLoops = 0
                buttonAudioPlayer?.play()
            } catch {
                print("Could not play click music: \(error.localizedDescription)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        backgroundAudioPlayer?.stop()
    }
    
    func setVolume(_ volume: Float) {
        backgroundAudioPlayer?.volume = volume
    }
}




