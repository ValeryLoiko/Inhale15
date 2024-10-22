//
//  InstructionViewController.swift
//  Inhale15
//
//  Created by Diana on 21/10/2024.
//

import UIKit
import SnapKit

class InstructionViewController: UIViewController {
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать! На следующем экране вы сможете начать дыхательную гимнастику. Следуйте инструкциям и дышите глубоко."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        // Ошибка может возникнуть здесь, если ты не используешь экземпляр контроллера
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("InstructionViewController")
        view.backgroundColor = .white
        
        setupViews()
    }
    private func setupViews() {
        view.addSubview(instructionLabel)
        view.addSubview(nextButton)
        
        instructionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func nextButtonTapped() {
        print("Кнопка нажата")
        let timerViewController = TimerViewController()
     
        timerViewController.modalTransitionStyle = .crossDissolve
        timerViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(timerViewController, animated: true) // Нативный переход
      //  present(timerViewController, animated: true)
    }
    
}
