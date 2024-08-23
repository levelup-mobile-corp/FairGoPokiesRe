//
//  Settings.swift
//  FairGoPokies
//
//  Created by Oleksii  on 31.05.2024.
//

import SwiftUI

struct Settings: View {
    @AppStorage("koala") var koala: String = "koala1"
    @AppStorage("background") var background: String = "background1"
    @ObservedObject var viewModel = SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
                .ignoresSafeArea()
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    BackButton {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Image("Settings")
                    Spacer()
                    Balance()
                    
                }
                .padding(.horizontal)
                Spacer()
                VStack(spacing: 24) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 108)
                        .foregroundStyle(Color.blueGradient)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                        }
                        .overlay {
                            HStack(spacing: 8) {
                                Button {
                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                    SoundManager.shared.playClick()
                                    viewModel.isShowingImagePicker = true
                                } label: {
                                    if let selectedImage = viewModel.selectedImage { Image(uiImage: selectedImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 62, height: 62)
                                            .clipShape(Circle())
                                    } else {
                                        Image("avatar")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 62, height: 62)
                                            .clipShape(Circle())
                                    }
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Username")
                                        .foregroundColor(Color.white)
                                        .font(.custom("JosefinSans-Medium", size: 20))
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundStyle(Color.lightBlueGradient)
                                        .overlay {
                                            TextField("", text: $viewModel.name, prompt: Text("Name").foregroundColor(Color.white).font(.custom("JosefinSans-Medium", size: 16)))
                                                .foregroundColor(Color.white)
                                                .font(.custom("JosefinSans-Medium", size: 16))
                                                .padding(10)
                                        }
                                }
                            }
                            .padding(16)
                        }
                    
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 56)
                            .foregroundStyle(Color.blueGradient)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                            }
                            .overlay {
                                Toggle(isOn: $viewModel.sound) {
                                    Text("Music")
                                        .foregroundColor(Color.white)
                                        .font(.custom("JosefinSans-Medium", size: 20))
                                }
                                .onChange(of: viewModel.sound) { newValue in
                                    if newValue {
                                        SoundManager.shared.playBackgroundMusic()
                                    } else {
                                        SoundManager.shared.stopBackgroundMusic()
                                    }
                                }
                                .padding(10)
                            }
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 56)
                            .foregroundStyle(Color.blueGradient)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                            }
                            .overlay {
                                Toggle(isOn: $viewModel.click) {
                                    Text("Sound")
                                        .foregroundColor(Color.white)
                                        .font(.custom("JosefinSans-Medium", size: 20))
                                }
                                .onChange(of: viewModel.click) { newValue in
                                    SoundManager.shared.playClick()
                                }
                                .padding(10)
                            }
                        
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 56)
                            .foregroundStyle(Color.blueGradient)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(LinearGradient(colors: [Color(hex: "D22ACB"), Color(hex: "5B22FF")], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                            }
                            .overlay {
                                Toggle(isOn: $viewModel.haptic) {
                                    Text("Haptics")
                                        .foregroundColor(Color.white)
                                        .font(.custom("JosefinSans-Medium", size: 20))
                                }
                                .onChange(of: viewModel.haptic) { newValue in
                                    HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                                }
                                .padding(10)
                            }
                    }
                    
                    NavigationLink {
                        PrivacyView()
                    } label: {
                        CustomButton(text: "Privacy policy", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                            .frame(width: 210)
                    }
                    
                    NavigationLink {
                        BonusView()
                    } label: {
                        CustomButton(text: "Daily Bonus", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                            .frame(width: 210)
                    }

                }
                .frame(width: 360)
                
                Spacer()
            }
            .sheet(isPresented: $viewModel.isShowingImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage, isPresented: $viewModel.isShowingImagePicker)
            }
        }
        .navigationBarHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image("Settings")
                }
            }
        })
        .onDisappear{
            if let selectedImage = viewModel.selectedImage {
                viewModel.profileImageData = selectedImage.jpegData(compressionQuality: 0.5)
            }
        }
        .onAppear{
            if let profileImageData = viewModel.profileImageData {
                viewModel.selectedImage = UIImage(data: profileImageData)
            }
        }
    }
}

#Preview {
    Settings()
}

struct CustomToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Toggle Switch")
        }
        .toggleStyle(SwitchToggleStyle(tint: .green))
        .padding()
    }
}
