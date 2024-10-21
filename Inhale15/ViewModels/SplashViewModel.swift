//
//  SplashViewModel.swift
//  Inhale15
//
//  Created by Diana on 21/10/2024.
//

import Foundation

class SplashViewModel {
    func startSplashTimer(compliction: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            compliction()
        }
    }
}
