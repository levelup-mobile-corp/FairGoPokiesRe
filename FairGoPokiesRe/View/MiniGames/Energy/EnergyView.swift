//
//  EnergyView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 02.06.2024.
//

import SwiftUI
import SpriteKit

struct EnergyView: View {
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    @StateObject var viewModel: EnergyViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var score = 0
    
    init() {
        self._viewModel = StateObject(wrappedValue: EnergyViewModel())
    }
    
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
//                        scene.restartGame()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Image("energy")
                            .resizable()
                            .frame(width: 60, height: 43)
                        CustomProgressBar(progress: viewModel.energy)
                            .frame(width: 150)
                    }
                    Spacer()
                    Balance()
                    
                }
                .padding(.horizontal)
                ZStack {
                    VStack {
                        Rectangle()
                            .foregroundStyle(Color.lightBlueGradient)
                            .frame(height: 2)
                        Rectangle()
                            .foregroundStyle(Color.lightBlueGradient)
                            .frame(height: 2)
                        Rectangle()
                            .foregroundStyle(Color.lightBlueGradient)
                            .frame(height: 2)
                    }
                    SKViewContainer(viewModel: viewModel, scene: NoteScene(size: CGSize(width: UIScreen.main.bounds.width, height: 300)))
                    
                }
                .frame(height: 200)
                
                    VStack(spacing: 40) {
                        HStack(spacing: 40) {
                            ForEach(["A", "D", "F"], id: \.self) { note in
                                Button(action: {
                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                    SoundManager.shared.playClick()
                                    viewModel.notePressed(note: note)
                                }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(Color.blueGradient)
                                        .frame(width: 75, height: 75)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                        }
                                        .overlay {
                                            Image(note)
                                        }
                                }
                            }
                        }
                        
                        HStack(spacing: 40) {
                            ForEach(["G", "E", "C"], id: \.self) { note in
                                Button(action: {
                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                    SoundManager.shared.playClick()
                                    viewModel.notePressed(note: note)
                                }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(Color.blueGradient)
                                        .frame(width: 75, height: 75)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                        }
                                        .overlay {
                                            Image(note)
                                        }
                                }
                            }
                        }
                    }
                Spacer()
            }
            .padding(.top)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 300)
                .padding()
                .foregroundStyle(Color.yellowGradient)
                .overlay {
                    VStack {
                        Text(viewModel.isWin ? "Congratulations. The power is fully restored" : "Game over. You've lost")
                            .multilineTextAlignment(.center)
                            .font(.custom("LondrinaSolid-Regular", size: 40))
                            .foregroundColor(Color(hex: "464B30"))
                        HStack {
                            Button(action: {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                if viewModel.isWin {
                                    viewModel.energy = 8
                                }
//                                scene.restartGame()
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
                            
                            Button(action: {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                viewModel.restart()
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
                .opacity(viewModel.isGameOver ? 1 : 0)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    EnergyView()
}

struct SKViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: EnergyViewModel
    var scene: NoteScene
    
    func makeUIView(context: Context) -> some UIView {
        let skView = SKView()
        skView.ignoresSiblingOrder = true
        
        skView.frame = UIScreen.main.bounds
        
        skView.backgroundColor = .clear
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        viewModel.delegate = scene
        scene.viewModel = viewModel
        
        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct CustomLoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(Color.blue, lineWidth: 5)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .frame(width: 50, height: 50)
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}
