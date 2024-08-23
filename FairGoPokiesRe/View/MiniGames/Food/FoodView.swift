//
//  FoodView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 04.06.2024.
//

import SwiftUI
import SpriteKit

struct FoodView: View {
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    @ObservedObject var viewModel = FoodViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var gameScene = GameScene(size: CGSize(width: 4 * (75 + 20) - 20, height: 5 * (75 + 20) - 20))
    
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    BackButton {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Image("food")
                            .resizable()
                            .frame(width: 60, height: 43)
                        CustomProgressBar(progress: viewModel.food)
                            .frame(width: 150)
                    }
                    Spacer()
                    Balance()
                    
                }
                .padding(.horizontal)
                SKViewContainerFood(viewModel: viewModel, scene: $gameScene)
                    .frame(maxWidth: 4 * (75 + 20) - 20, maxHeight: 5 * (75 + 20) - 20)
                    .padding(.top)
                Spacer()
                HStack {
                    Button(action: { moveKoala(direction: .left) }) {
                        Image("leftBTN")
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    Button(action: { moveKoala(direction: .up) }) {
                        Image("upBTN")
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    Button(action: { moveKoala(direction: .down) }) {
                        Image("downBTN")
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    Button(action: { moveKoala(direction: .right) }) {
                        Image("rightBTN")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .disabled(viewModel.isGameOver)
                .frame(height: 56)
                .padding()
            }
            .padding(.top)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 300)
                .padding()
                .foregroundStyle(Color.yellowGradient)
                .overlay {
                    VStack {
                        Text(viewModel.isWin ? "Congratulations. The food is fully restored" : "Game over. You've lost")
                            .multilineTextAlignment(.center)
                            .font(.custom("LondrinaSolid-Regular", size: 40))
                            .foregroundColor(Color(hex: "464B30"))
                        HStack {
                            Button(action: {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                if viewModel.isWin {
                                    viewModel.food = 8
                                }
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(Color.blueGradient)
                                    .frame(width: 150, height: 44)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    }
                                    .overlay {
                                        Text("Exit")
                                            .font(.custom("LondrinaSolid-Regular", size: 25))
                                            .foregroundStyle(.white)
                                    }
                            }
                            if !viewModel.isWin {
                                Button(action: {
                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                    SoundManager.shared.playClick()
                                    gameScene.resetGame()
                                }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(Color.blueGradient)
                                        .frame(width: 150, height: 44)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                        }
                                        .overlay {
                                            Text("Restart")
                                                .font(.custom("LondrinaSolid-Regular", size: 25))
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                        }
                        
                    }
                    .padding()
                }
                .opacity(viewModel.isGameOver ? 1 : 0)
        }
        .navigationBarHidden(true)
    }
    
    func moveKoala(direction: Direction) {
        switch direction {
        case .left:
            gameScene.moveKoala(byRow: 0, byCol: -1)
        case .right:
            gameScene.moveKoala(byRow: 0, byCol: 1)
        case .up:
            gameScene.moveKoala(byRow: 1, byCol: 0)
        case .down:
            gameScene.moveKoala(byRow: -1, byCol: 0)
        }
    }
    
    enum Direction {
        case up, down, left, right
    }
}

struct SKViewContainerFood: UIViewRepresentable {
    @ObservedObject var viewModel: FoodViewModel
    @Binding var scene: GameScene
    
    func makeUIView(context: Context) -> some UIView {
        let skView = SKView()
        skView.ignoresSiblingOrder = true
        skView.frame = UIScreen.main.bounds
        skView.backgroundColor = .clear
        
        let scene = self.scene
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        scene.viewModel = viewModel
        
        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    FoodView()
}

struct CustomStepper: View {
    @Binding var value: Int
    var range: ClosedRange<Int>
    
    var body: some View {
        HStack {
            Button(action: { if value > range.lowerBound { value -= 1 } }) {
                Text("-")
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            Text("\(value)")
                .frame(width: 50)
            
            Button(action: { if value < range.upperBound { value += 1 } }) {
                Text("+")
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
