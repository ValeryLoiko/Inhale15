//
//  TimerViewModel.swift
//  Inhale15
//
//  Created by Diana on 23/10/2024.
//

import Foundation

class TimerViewModel {
    private var timer: Timer?
    private var isRunning = false
    private var milliseconds = 0
    private var uiUpdateInterval = 10 // Обновляем UI каждые 0.1 секунды (10 раз по 0.01 секунды)
    private var tickCounter = 0
    
    var onTimeUpdate: ((String) -> Void)?
    var onTimerStateChanged: ((Bool) -> Void)?
    var onResultsUpdate: (() -> Void)?
    
    // Массив для хранения результатов
    var results: [String] = []
    
    func toggleTimer() {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
        onTimerStateChanged?(isRunning)
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }
    
    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        pauseTimer()
        
        // Сохраняем результат перед сбросом
        let result = formatTime(milliseconds: milliseconds)
        results.append(result)
        onResultsUpdate?()  // Уведомляем контроллер, чтобы он обновил таблицу
        
        // Сброс значений
        milliseconds = 0
        onTimeUpdate?(formatTime(milliseconds: milliseconds))
        onTimerStateChanged?(isRunning)
    }
    
    private func updateTime() {
        milliseconds += 1
        tickCounter += 1
        
        // Обновляем UI только раз в 0.1 секунды
        if tickCounter >= uiUpdateInterval {
            tickCounter = 0
            onTimeUpdate?(formatTime(milliseconds: milliseconds))
        }
    }
    
    private func formatTime(milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 100
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let milli = milliseconds % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, milli)
    }
}
