//
//  MainView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//

import SwiftUI

struct MainView: View {
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    @ObservedObject var viewModel = MainViewModel()
    @State var start: Bool = true
    var body: some View {
        NavigationView {
            ZStack {
                Image(background)
                    .resizable()
                    .ignoresSafeArea()
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                VStack {
                    HStack(spacing: 20) {
                        VStack {
                            NavigationLink {
                                FoodView()
                            } label: {
                                VStack(spacing: 4) {
                                    Image("food")
                                        .resizable()
                                        .frame(width: 60, height: 62)
                                    CustomProgressBar(progress: viewModel.food)
                                }
                            }
                            .disabled(viewModel.food > 7)
                            Spacer()
                            NavigationLink {
                                EnergyView()
                            } label: {
                                VStack(spacing: 4) {
                                    Image("energy")
                                        .resizable()
                                        .frame(width: 60, height: 43)
                                    CustomProgressBar(progress: viewModel.energy)
                                }
                            }
                            .disabled(viewModel.energy > 7)
                        }
                        VStack {
                            HStack {
                                Spacer()
                                Balance()
                            }
                            Spacer()
                            NavigationLink {
                                BrainView()
                            } label: {
                                VStack(spacing: 4) {
                                    Image("brain")
                                        .resizable()
                                        .frame(width: 36, height: 60)
                                    CustomProgressBar(progress: viewModel.brain)
                                }
                            }
                            .disabled(viewModel.brain > 7)
                        }
                    }
                    .frame(height: 165)
                    Spacer()
                    VStack(spacing: 8) {
                        NavigationLink {
                            Settings()
                        } label: {
                            CustomButton(text: "Settings", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                        }

                        NavigationLink {
                            TutorialView()
                        } label: {
                            CustomButton(text: "Tutorial", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                        }
                        
                        NavigationLink {
                            StoreView()
                        } label: {
                            CustomButton(text: "Shop", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                        }
                    }
                    .frame(width: 210)
                    Spacer()
                    Image(koala)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 230)
                }
                .padding()
            }
            .onAppear {
                print("dididi")
                SoundManager.shared.playBackgroundMusic()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MainView()
}

class CounterViewModel: ObservableObject {
    @Published var count: Int = 0
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
}
