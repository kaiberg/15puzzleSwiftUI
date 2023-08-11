//
//  PuzzleState.swift
//  15puzzle
//
//  Created by kai delay on 05/08/2023.
//

import Foundation
import SwiftUI
import SwiftData

class PuzzleState: ObservableObject {
    
    @Published var game = GameState()
    @Published var options = OptionState(correct: Color(.sRGB, red: 195 / 255.0, green: 232 / 255.0, blue: 49 / 255.0, opacity: 0.5),
                                         empty: Color(.sRGB, red: 94 / 255.0, green: 94 / 255.0, blue: 94 / 255.0, opacity: 0.07),
                                         wrong: Color(.sRGB, red: 237 / 255.0, green: 66 / 255.0, blue: 69 / 255.0, opacity: 0.5),
                                         saveGameStatistics: false)
    @Published var lastGestureTime: Date = Date()
    @Published var time: Int = 0
    private var timer: Timer?
    private var isPaused: Bool = false
    
    init() {
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] _ in
            if !self.isPaused {
                self.time += 1
            }
        }
    }
    
    func pause() {
        self.isPaused = !isPaused
    }
    
    func reset() {
        game.Initialize()
        resetTimer()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        time = 0
        startTimer()
    }
    
    func move(direction: Direction) {
        if(!isPaused) {
            game.move(direction: direction)
        }
    }
    
    func saveGame(context : ModelContext) {
        if(options.saveGameStatistics && game.hasWon) {
            let record = GameRecord(date: Date.now, moves: game.moves, timeTaken: time, difficulty: game.difficulty)
            context.insert(record)
        }
    }
}

