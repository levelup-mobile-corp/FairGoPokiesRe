//
//  Loader.swift
//  FairGoPokies
//
//  Created by Oleksii  on 29.05.2024.
//

import UIKit
import SwiftUI
import Lottie

class LoaderViewController: UIViewController {
    @AppStorage("brain") var brain: Int = 3
    @AppStorage("food") var food: Int = 3
    @AppStorage("energy") var energy: Int = 3
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }

    private func setupAnimation() {
        animationView = LottieAnimationView(name: "Loader")
        animationView?.fillSuperView()
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .playOnce
        animationView?.frame.size.height += 8
        view.addSubview(animationView!)
        animationView?.play { [weak self] finished in
            if finished {
                self?.minusStat()
                self?.showSwiftUIView()
            } else {
                print("not finished")
            }
        }
    }

    func setRootViewController(_ viewController: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewController
      }
    }
    private func showSwiftUIView() {
        let swiftUIView = MainView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
        setRootViewController(hostingController)
    }
    
    private func minusStat() {
        brain -= Int.random(in: 0...brain)
        food -= Int.random(in: 0...food)
        energy -= Int.random(in: 0...energy)
    }
}

extension UIView {
  func fillSuperView() {
    guard let superview = self.superview else { return }
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: superview.topAnchor),
      self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
      self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
    ])
  }
}

struct LoaderView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoaderViewController {
        return LoaderViewController()
    }

    func updateUIViewController(_ uiViewController: LoaderViewController, context: Context) {
        
    }
}

