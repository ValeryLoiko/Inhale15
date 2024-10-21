//
//  InstructionViewController.swift
//  Inhale15
//
//  Created by Diana on 21/10/2024.
//

import UIKit
import SnapKit

class InstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("InstructionViewController")
        view.backgroundColor = .lightGray
            
            let label = UILabel()
            label.text = "Инструкция по дыхательной гимнастике"
            label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            label.textColor = .white
            view.addSubview(label)
            
            // Устанавливаем констрейнты с помощью SnapKit
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
    }
    
}
