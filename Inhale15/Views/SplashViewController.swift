//
//  ViewController.swift
//  Inhale15
//
//  Created by Diana on 17/10/2024.
//

import UIKit
import Lottie
import SnapKit


class SplashViewController: UIViewController {
    private let viewModel = SplashViewModel()
    private var animateionView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupSplashScreen()
        
        viewModel.startSplashTimer {
       //     self.navigateToInstructionScreen()
        }
    }
    
    private func setupBackground() {
         // Добавляем фоновое изображение
         let backgroundImage = UIImageView(image: UIImage(named: "background.jpg"))
         backgroundImage.contentMode = .scaleAspectFill
         view.addSubview(backgroundImage)
         
         // Констрейнты для фона
         backgroundImage.snp.makeConstraints { make in
             make.edges.equalToSuperview()  // Фон заполняет весь экран
         }
     }
    
    private func setupSplashScreen() {
        animateionView = LottieAnimationView(name: "Animation - 1727784149695.json")
        guard let animationView = animateionView else { return }
        
        // Добавляем анимацию на экран
        
        view.addSubview(animationView)
        
        // Устанавливаем констрейнты с помощью SnapKit
        animationView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(300)
            $0.height.equalTo(100)
            // Задаем размеры
        }
        
        animationView.layer.cornerRadius = 20  // Задаем радиус закругления
           animationView.clipsToBounds = true
        
        animationView.loopMode = .loop
        animationView.play()
        
    }
    private func navigateToInstructionScreen() {
        let instructioVC = InstructionViewController()
        instructioVC.modalTransitionStyle = .crossDissolve
        instructioVC.modalPresentationStyle = .fullScreen
        present(instructioVC, animated: true)
    }
    
}

