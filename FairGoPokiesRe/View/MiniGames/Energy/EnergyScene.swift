//
//  EnergyScene.swift
//  FairGoPokies
//
//  Created by Oleksii  on 03.06.2024.
//


import Foundation
import SwiftUI
import SpriteKit


class NoteScene: SKScene {
    weak var viewModel: EnergyViewModel?
    let noteNames = ["C", "D", "E", "F", "G", "A"]
    var notes = [SKSpriteNode]()
    var score = 0
    var noteCount = 0
    
    override func didMove(to view: SKView) {
//        restartGame()
        startGame()
    }
    
    func startGame() {
        run(SKAction.repeat(SKAction.sequence([
            SKAction.run(spawnNote),
            SKAction.wait(forDuration: TimeInterval.random(in: 1...2))
        ]), count: 20))
    }
    
    func spawnNote() {
        let noteName = noteNames.randomElement()!
        let note = SKSpriteNode(imageNamed: noteName)
        note.name = noteName
        note.position = CGPoint(x: size.width + note.size.width / 2, y: size.height / 2)
        note.size = CGSize(width: 70, height: 70)
        addChild(note)
        notes.append(note)
        
        let moveAction = SKAction.moveBy(x: -size.width - note.size.width, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, removeAction])
        note.run(sequence)
        
        noteCount += 1
        if noteCount >= 20 {
            run(SKAction.wait(forDuration: 5)) {
                self.checkGameOver()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for note in notes {
            if note.position.x < 0 {
                gameOver()
                return
            }
        }
    }
    
    func checkGameOver() {
        if notes.isEmpty {
            withAnimation(.easeInOut) {
                viewModel?.isGameOver = true
                viewModel?.isWin = true
                removeAllActions()
                removeAllChildren()
            }
            
        }
    }
    
    func gameOver() {
        withAnimation(.easeInOut) {
            viewModel?.isGameOver = true
            viewModel?.isWin = false
            removeAllActions()
            removeAllChildren()
        }
    }
    
    func handleNotePress(noteName: String) {
        for note in notes {
            if note.name == noteName && note.position.x < size.width {
                // Добавляем анимацию исчезновения
                let fadeOut = SKAction.fadeOut(withDuration: 0.5) // Продолжительность анимации 0.5 секунды, можно изменить по вашему желанию
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([fadeOut, remove])
                note.run(sequence)
                
                // Удаляем ноту из массива после завершения анимации
                if let index = notes.firstIndex(where: { $0 == note }) {
                    notes.remove(at: index)
                }
                
                // Увеличиваем счет
                score += 1
                break
            }
        }
    }

    
    func restartGame() {
            score = 0
            noteCount = 0
            notes = [SKSpriteNode]()
            removeAllActions()
            removeAllChildren()
            viewModel?.isGameOver = false
            viewModel?.isWin = false
        }
}

extension NoteScene: EnergySceneDelegate {
    
    func notePressed(note: String) {
        self.handleNotePress(noteName: note)
    }
    
    func restartGamePressed() {
        self.restartGame()
        self.startGame()
    }
    
}

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
