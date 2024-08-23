//
//  BrainView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 03.06.2024.
//

import SwiftUI

struct BrainView: View {
    @ObservedObject var viewModel = QuizViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            QuestionView(question: viewModel.questions[viewModel.currentQuestionIndex], viewModel: viewModel, presentationMode: _presentationMode)
        }
        .navigationBarHidden(true)
    }
}

struct QuestionView: View {
    let question: Question
    @ObservedObject var viewModel: QuizViewModel
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                ZStack {
                    HStack {
                        BackButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                        Balance()
                        
                    }
                    
                    VStack(spacing: 4) {
                        Image("brain")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 43)
                        CustomProgressBar(progress: viewModel.brains)
                            .frame(width: 150)
                    }
                }
//                .padding(.bottom, 16)
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.lightBlueGradient)
                    .frame(height: 50)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(LinearGradient(colors: [Color(hex: "112B4C"), Color(hex: "78B3FA")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                    }
                    .overlay {
                        HStack {
                            Button {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                viewModel.isKoalaMode = true
                                viewModel.koalaAnswer()
                            } label: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 40)
                                    .foregroundStyle(viewModel.isKoalaMode ? LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(viewModel.isKoalaMode ? LinearGradient(colors: [Color(hex: "5B22FF"), Color(hex: "D22ACB")], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    }
                                    .overlay {
                                        Text("Koala")
                                            .font(.custom("JosefinSans-Medium", size: 20))
                                            .foregroundStyle(Color.white)
                                    }
                            }

                            
                            Button {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                viewModel.isKoalaMode = false
                            } label: {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 40)
                                    .foregroundStyle(!viewModel.isKoalaMode ? LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(!viewModel.isKoalaMode ? LinearGradient(colors: [Color(hex: "5B22FF"), Color(hex: "D22ACB")], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    }
                                    .overlay {
                                        Text(viewModel.name.isEmpty ? "Username" : viewModel.name)
                                            .font(.custom("JosefinSans-Medium", size: 20))
                                            .foregroundStyle(Color.white)
                                    }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding(.vertical)
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color.blueGradient)
                    .frame(height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                    }
                    .overlay {
                        Text(question.text)
                            .padding(10)
                            .foregroundStyle(.white)
                            .font(.custom("JosefinSans-Medium", size: 20))
                    }
                    .padding(.vertical)
                
                HStack {
                    VStack(spacing: 20) {
                        ForEach(0...1, id: \.self) { index in
                            Button(action: {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                viewModel.submitAnswer(index: index)
                                
                            }) {
                                RoundedRectangle(cornerRadius: 24)
                                    .foregroundStyle(viewModel.selectedAnswerIndex == index ?  (viewModel.selectedAnswerIndex == question.correctAnswerIndex ? Color.greenGradient : LinearGradient(colors: [Color(hex: "F14B4B"), Color(hex: "A52222")], startPoint: .leading, endPoint: .trailing)) : Color.yellowGradient)
                                    .frame(height: 60)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(viewModel.selectedAnswerIndex == index ?  (viewModel.selectedAnswerIndex == question.correctAnswerIndex ? Color.greenGradient : LinearGradient(colors: [Color(hex: "F14B4B"), Color(hex: "A52222")], startPoint: .leading, endPoint: .trailing)) : LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    }
                                    .overlay {
                                        Text(question.options[index])
                                            .font(.custom("JosefinSans-Medium", size: 20))
                                            .foregroundStyle(viewModel.selectedAnswerIndex == index ? Color.white : Color(hex: "464B30"))
                                    }
                            }
                            .disabled(viewModel.selectedAnswerIndex != nil)
                            .disabled(viewModel.isKoalaMode)
                        }
                    }
                    VStack(spacing: 20) {
                        ForEach(2...3, id: \.self) { index in
                            Button(action: {
                                HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                SoundManager.shared.playClick()
                                viewModel.selectedAnswerIndex = index
                                viewModel.submitAnswer(index: index)
                                
                            }) {
                                RoundedRectangle(cornerRadius: 24)
                                    .foregroundStyle(viewModel.selectedAnswerIndex == index ?  (viewModel.selectedAnswerIndex == question.correctAnswerIndex ? Color.greenGradient : LinearGradient(colors: [Color(hex: "F14B4B"), Color(hex: "A52222")], startPoint: .leading, endPoint: .trailing)) : Color.yellowGradient)
                                    .frame(height: 60)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(viewModel.selectedAnswerIndex == index ?  (viewModel.selectedAnswerIndex == question.correctAnswerIndex ? Color.greenGradient : LinearGradient(colors: [Color(hex: "F14B4B"), Color(hex: "A52222")], startPoint: .leading, endPoint: .trailing)) : LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    }
                                    .overlay {
                                        Text(question.options[index])
                                            .font(.custom("JosefinSans-Medium", size: 20))
                                            .foregroundStyle(viewModel.selectedAnswerIndex == index ? Color.white : Color(hex: "464B30"))
                                    }
                            }
                            .disabled(viewModel.selectedAnswerIndex != nil)
                            .disabled(viewModel.isKoalaMode)
                        }
                    }
                }
                Button {
                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                    SoundManager.shared.playClick()
                    viewModel.goToNextQuestion()
                    if viewModel.isKoalaMode {
                        viewModel.koalaAnswer()
                    }
                } label: {
                    CustomButton(text: "Next", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                }
                .opacity(viewModel.selectedAnswerIndex == nil ? 0 : 1)
                
                ZStack {
                    Image("koala1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    VStack {
                        Spacer()
                        Spacer()
                        Image("cloud")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                            .overlay {
                                VStack {
                                    Spacer()
                                    Spacer()
                                    Text(viewModel.koalaText)
                                        .font(.custom("LondrinaSolid-Regular", size: 20))
                                        .foregroundStyle(Color.black)
                                    Spacer()
                                }
                            }
                        Spacer()
                    }
                }
            }
            .padding()
            .padding(.top)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 300)
                .padding()
                .foregroundStyle(Color.yellowGradient)
                .overlay {
                    VStack {
                        Text("Congratulations. The brain is fully restored")
                            .multilineTextAlignment(.center)
                            .font(.custom("LondrinaSolid-Regular", size: 40))
                            .foregroundColor(Color(hex: "464B30"))
                        Button(action: {
                            HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                            SoundManager.shared.playClick()
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
                                }
                        }
                        
                    }
                    .padding()
                }
                .opacity(viewModel.isGameOver || viewModel.brain > 7 ? 1 : 0)
        }
        .onDisappear {
            viewModel.brain = viewModel.brains
        }
    }
}


#Preview {
    BrainView()
}

struct CustomAlert: View {
    var title: String
    var message: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .padding()
            Button("OK", action: action)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
