//
//  BonusView.swift
//  FairGoPokies
//
//  Created by Oleksii  on 02.06.2024.
//

import SwiftUI
import Lottie

struct BonusView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isReadyBonus") var isReadyBonus: Bool = true
    @AppStorage("remainingTime") private var remainingTime: TimeInterval = 24 * 60 * 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showLottieFullscreen = false
    @State private var showReward = false
    @AppStorage("balance") var balance: Int = 0
    
    var body: some View {
        ZStack {
            Image("BonusBG")
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    BackButton(action: {
                        HapticFeedbackManager.shared.triggerHapticFeedback(style: .medium)
                        SoundManager.shared.playClick()
                        presentationMode.wrappedValue.dismiss()
                    })
                    Spacer()
                }
                Spacer()
            }
            .padding()
            if !isReadyBonus {
                VStack(spacing: 50) {
                    Image("BonusNotReady")
                    Image("Bonus")
                    StrokeText(text: "It will be open after \(timeString(time: remainingTime))", width: 2, color: Color(hex: "3A2D1D"))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.yellowGradient)
                        .font(.custom("LondrinaSolid-Regular", size: 40))
                        .frame(width: 300)
                }
                .onReceive(timer) { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        withAnimation(.easeInOut) {
                            isReadyBonus = true
                        }
                        remainingTime = 24 * 60 * 60
                    }
                }
            } else {
//                if showLottieFullscreen {
                    ZStack {
                        VStack(spacing: 50) {
                            Image("DailyBonus")
                            Image("openBonus")
                            Text("+10000 Coins")
                                .foregroundStyle(Color.white)
                                .font(.custom("LondrinaSolid-Regular", size: 36))
                                .shadow(color: .white.opacity(0.75), radius: 20, x: 0, y: 0)
                                .shadow(color: Color(hex:"37ABFF"), radius: 4, x: 0, y: 4)
                        }
                    }
                    .opacity(showLottieFullscreen ? 1 : 0)
                    .onTapGesture {
                        isReadyBonus = false
                        balance+=10000
                    }
//                } else {
                    VStack(spacing: 50) {
                        Image("DailyBonus")
                        Image("Bonus")
                        Image("TapToOpen")
                    }
                    .opacity(showLottieFullscreen ? 0 : 1)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 2)) {
                            showLottieFullscreen.toggle()
                        }
                        
//                        withAnimation(.easeInOut(duration: 3)) {
//                            showReward.toggle()
//                        }
                    }
//                }
                
//                if showLottieFullscreen {
//                    ZStack {
//                        BonusAnimationView(filename: "Bonus")
//                            .edgesIgnoringSafeArea(.all)
//                        VStack {
//                            Spacer()
//                            Image("coin")
//                                .resizable()
//                                .frame(width: 80, height: 80)
//                                .opacity(showReward ? 1 : 0)
//                            Spacer()
//                            Spacer()
//                            Text("+10000 Coins")
//                                .foregroundStyle(Color.white)
//                                .font(.custom("LondrinaSolid-Regular", size: 36))
//                                .shadow(color: .white.opacity(0.75), radius: 20, x: 0, y: 0)
//                                .shadow(color: Color(hex:"37ABFF"), radius: 4, x: 0, y: 4)
//                                .opacity(showReward ? 1 : 0)
//                            Spacer()
//                        }
//                    }
//                    .onTapGesture {
//                        isReadyBonus = false
//                        balance+=10000
//                    }
//                }
            }
        }
        .navigationBarHidden(true)
//        .animation(.easeInOut)
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) % 3600 / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
    }
}

#Preview {
    BonusView()
}

struct BonusAnimationView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    
    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
