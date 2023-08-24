//
//  SplashScreenView.swift
//  TMDBApp
//
//  Created by Pro on 02.04.2023.
//

import SwiftUI
import Lottie

struct SplashScreenView: UIViewRepresentable {
    
    let name = "intro"
    let loopMode:LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let animationView = LottieAnimationView()
        
        animationView.animation = LottieAnimation.named(name)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
    return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
