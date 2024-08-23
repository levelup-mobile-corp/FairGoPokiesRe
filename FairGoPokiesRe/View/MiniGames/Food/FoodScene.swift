//
//  FoodScene.swift
//  FairGoPokies
//
//  Created by Oleksii  on 04.06.2024.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    var viewModel: FoodViewModel?
    let numRows = 4
    let numCols = 4
    let platformSize = CGSize(width: 75, height: 75)
    let platformSpacing: CGFloat = 20
    let koala = SKSpriteNode(imageNamed: "koala1")
    var chest = SKSpriteNode(imageNamed: "tresuare")
    var koalaPosition = (row: 0, col: 0)
    var chestPosition = (row: 0, col: 0)
    var bombPositions = [(row: Int, col: Int)]()
    let bombTexture = SKTexture(imageNamed: "bomb")
    
    override func didMove(to view: SKView) {
//        removeAllChildren()
//        setupPlatforms()
//        setupKoala()
//        setupChest()
//        placeBombs()
        resetGame()
    }
    
    func placeBombs() {
        for row in 0..<4 {
//            let randomRow = Int.random(in: 0..<4)
            let randomCol = Int.random(in: 0..<4)
            bombPositions.append((row: row, col: randomCol))
        }
    }
    
    func setupPlatforms() {
        for row in 0..<numRows {
            for col in 0..<numCols {
                let platform = SKSpriteNode(imageNamed: "platform")
                platform.size = platformSize
                platform.position = CGPoint(x: CGFloat(col) * (platformSize.width + platformSpacing) + platformSize.width / 2,
                                            y: CGFloat(row) * (platformSize.height + platformSpacing) + platformSize.height / 2)
                platform.name = "platform\(row)\(col)"
                addChild(platform)
            }
        }
    }
    
    func setupKoala() {
        koala.size = platformSize
        koala.position = CGPoint(x: platformSize.width / 2, y: platformSize.height / 2)
        koala.zPosition = 2
        addChild(koala)
    }
    
    func setupChest() {
        let randomCol = Int.random(in: 0..<numCols)
        chest.size = platformSize
        chest.position = CGPoint(x: CGFloat(randomCol) * (platformSize.width + platformSpacing) + platformSize.width / 2,
                                 y: CGFloat(numRows) * (platformSize.height + platformSpacing) + platformSize.height / 2)
        chestPosition = (row: numRows, col: randomCol)
        addChild(chest)
    }
    
    func moveKoala(byRow row: Int, byCol col: Int) {
        let newRow = koalaPosition.row + row
        let newCol = koalaPosition.col + col
        
        guard newRow >= 0, newRow < numRows, newCol >= 0, newCol < numCols else { return }
        
        koalaPosition = (row: newRow, col: newCol)
        koala.position = CGPoint(x: CGFloat(newCol) * (platformSize.width + platformSpacing) + platformSize.width / 2,
                                 y: CGFloat(newRow) * (platformSize.height + platformSpacing) + platformSize.height / 2)
        checkForBombCollision()
        if viewModel?.isGameOver == false{
            checkForChestCollision()
        }
    }
    
    func checkForChestCollision() {
        if koalaPosition.row == chestPosition.row-1 && koalaPosition.col == chestPosition.col {
            chest.texture = SKTexture(imageNamed: "openTresuare")
            if viewModel?.isGameOver == false {
                withAnimation(.easeInOut) {
                    viewModel?.isWin = true
                    viewModel?.isGameOver = true
                }
            }
        } else {
            chest.texture = SKTexture(imageNamed: "tresuare")
        }
    }
    
    func checkForBombCollision() {
            for bombPosition in bombPositions {
                if koalaPosition.row == bombPosition.row && koalaPosition.col == bombPosition.col {
                    print("Boom")
                    let platform = childNode(withName: "platform\(bombPosition.row)\(bombPosition.col)") as? SKSpriteNode
                                    platform?.texture = bombTexture
                    platform?.zPosition = 3
                    withAnimation(.easeInOut) {
                        viewModel?.isWin = false
                        viewModel?.isGameOver = true
                    }
                }
            }
        }
    
    func resetGame() {
        removeAllChildren()
        bombPositions = []
        koalaPosition = (row: 0, col: 0)
        withAnimation(.easeInOut) {
            viewModel?.isGameOver = false
            viewModel?.isWin = false
        }
        setupPlatforms()
        setupKoala()
        setupChest()
        placeBombs()
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
