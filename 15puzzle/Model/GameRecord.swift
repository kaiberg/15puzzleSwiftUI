//
//  GameRecord.swift
//  15puzzle
//
//  Created by kai delay on 11/08/2023.
//

import Foundation
import SwiftData

@Model
final class GameRecord {
    var date: Date
    var moves: Int
    var timeTaken: Int
    private var _difficulty: String
    var difficulty: Difficulty {
        return Difficulty(rawValue: self._difficulty) ?? .easy
    }
    
    init(date: Date, moves: Int, timeTaken: Int, difficulty: Difficulty) {
        self.date = date
        self.moves = moves
        self.timeTaken = timeTaken
        self._difficulty = difficulty.rawValue
    }
}
