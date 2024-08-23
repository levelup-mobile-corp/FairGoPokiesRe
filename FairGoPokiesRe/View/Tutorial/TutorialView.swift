//
//  TutorialView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 02.06.2024.
//

import SwiftUI

struct TutorialView: View {
    @State var tutorialPage: Int = 1
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image("Tutorial\(tutorialPage)")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack(spacing: 8) {
                    Button {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        tutorialPage -= 1
                    } label: {
                        CustomButton(text: "Previous", color: Color.lightBlueGradient, strokeColor: LinearGradient(colors: [Color(hex: "112B4C"), Color(hex: "78B3FA")], startPoint: .leading, endPoint: .trailing), fontColor: .white)
                    }
                    .disabled(tutorialPage == 1)
                    .opacity(tutorialPage == 1 ? 0.6 : 1)
                    
                    Button {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        if tutorialPage == 4 {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            tutorialPage += 1
                        }
                    } label: {
                        CustomButton(text: tutorialPage == 4 ? "Finish" : "Next", color: Color.yellowGradient, strokeColor: LinearGradient(colors: [Color(hex: "F1F6E3"), Color(hex: "FFDB22")], startPoint: .leading, endPoint: .trailing), fontColor: Color(hex: "464B30"))
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    TutorialView()
}

class UserManager: ObservableObject {
    @Published var username: String = ""
    @Published var isLoggedIn: Bool = false
    
    func logIn(username: String) {
        self.username = username
        self.isLoggedIn = true
    }
    
    func logOut() {
        self.username = ""
        self.isLoggedIn = false
    }
}
