//
//  StoreView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 04.06.2024.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject var viewModel = StoreViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(viewModel.background)
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 24) {
                HStack {
                    BackButton {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Image("Shop")
                    Spacer()
                    Balance()
                }
                
                ScrollView {
                    VStack(spacing: 24) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(viewModel.koalaProducts) { koala in
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundStyle(Color.lightBlueGradient)
                                        .frame(width: 170, height: 280)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 24)
                                                .stroke(LinearGradient(colors: [Color(hex: "112B4C"), Color(hex: "78B3FA")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                        }
                                        .overlay {
                                            VStack(spacing: 10) {
                                                Image(koala.name)
                                                    .resizable()
                                                    .scaledToFit()
                                                
                                                Text("Skin")
                                                    .font(.custom("JosefinSans-Medium", size: 20))
                                                    .foregroundStyle(Color.white)
                                                
                                                Spacer()
                                                
                                                Button {
                                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                                    SoundManager.shared.playClick()
                                                    if koala.isBought {
                                                        viewModel.koala = koala.name
                                                    } else {
                                                        if viewModel.balance > 1000 {
                                                            viewModel.buyKoala(koala: koala)
                                                        } else {
                                                            TopMessage.show(message: "Not enough coins to buy")
                                                        }
                                                    }
                                                } label: {
                                                    CustomButton(text: !koala.isBought ? "Buy for 1000" : "Select", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                                                }
                                                .opacity(viewModel.koala == koala.name ? 0.6 : 1)
                                                .disabled(viewModel.koala == koala.name)
                                            }
                                            .padding(16)
                                        }
                                }
                            }
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(viewModel.backgroundProducts) { background in
                                    RoundedRectangle(cornerRadius: 24)
                                        .frame(width: 245, height: 316)
                                        .foregroundStyle(Color.blueGradient)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 24)
                                                .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                        }
                                        .overlay {
                                            VStack(spacing: 10) {
                                                Image(background.name)
                                                    .resizable()
                                                    .frame(width: 200, height: 200)
                                                    .cornerRadius(24)
                                                    .padding(3)
                                                    .background(Color.white)
                                                    .cornerRadius(24)
                                                    .shadow(color: Color(hex: "71E3F3").opacity(0.5), radius: 8, x: 0, y: 0)
                                                
                                                Text("Game background")
                                                    .font(.custom("JosefinSans-Medium", size: 20))
                                                    .foregroundStyle(Color.white)
                                                
                                                Button {
                                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                                    SoundManager.shared.playClick()
                                                    if background.isBought {
                                                        viewModel.background = background.name
                                                    } else {
                                                        if viewModel.balance > 1000 {
                                                            viewModel.buyBackground(background: background)
                                                        } else {
                                                            TopMessage.show(message: "Not enough coins to buy")
                                                        }
                                                    }
                                                } label: {
                                                    CustomButton(text: !background.isBought ? "Buy for 1000" : "Select", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                                                }
                                                .opacity(viewModel.background == background.name ? 0.6 : 1)
                                                .disabled(viewModel.background == background.name)
                                            }
                                            .padding(16)
                                        }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.loadKoalas()
            viewModel.loadBackgrounds()
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    StoreView()
}

protocol NetworkService {
    func performRequest(url: URL, completion: @escaping (Data?, Error?) -> Void)
}
