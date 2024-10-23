//
//  TimerViewController.swift
//  Inhale15
//
//  Created by Diana on 22/10/2024.
//

import UIKit

class TimerViewController: UIViewController {
    
    private var viewModel: TimerViewModel!
    
    // UI Elements
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.cornerRadius = 100 // Adjust for circle size
        return view
    }()
    
    private let startPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 35
        button.layer.masksToBounds = true
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сброс", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 35
        button.layer.masksToBounds = true
        return button
    }()
    
    // TableView для отображения результатов
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel = TimerViewModel()
        
        // TableView DataSource
        tableView.dataSource = self
        
        // Actions
        startPauseButton.addTarget(self, action: #selector(startPauseTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        
        // Bind to ViewModel
        viewModel.onTimeUpdate = { [weak self] timeString in
            self?.timerLabel.text = timeString
        }
        viewModel.onTimerStateChanged = { [weak self] isRunning in
            if isRunning {
                self?.startPauseButton.setTitle("Стоп", for: .normal)
                self?.startPauseButton.backgroundColor = .systemRed
            } else {
                self?.startPauseButton.setTitle("Старт", for: .normal)
                self?.startPauseButton.backgroundColor = .systemBlue
            }
        }
        viewModel.onResultsUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(circleView)
        view.addSubview(timerLabel)
        view.addSubview(startPauseButton)
        view.addSubview(resetButton)
        view.addSubview(tableView)
        
        // Layout using SnapKit
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200) // Size of the circle
        }
        
        timerLabel.snp.makeConstraints { make in
            make.center.equalTo(circleView)
        }
        
        startPauseButton.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70) // Make it round
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(startPauseButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70) // Make it round
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(resetButton.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc private func startPauseTapped() {
        viewModel.toggleTimer()
    }
    
    @objc private func resetTapped() {
        viewModel.resetTimer()
    }
}

extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.results[indexPath.row]
        return cell
    }
}
