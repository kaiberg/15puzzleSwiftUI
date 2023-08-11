//
//  GameRecord.swift
//  15puzzle
//
//  Created by kai delay on 11/08/2023.
//

import Foundation
import SwiftData

@Model
class GameRecord {
    var date: Date
    var moves: Int
    var timeTaken: Int
    var difficulty: Difficulty
    
    init(date: Date, moves: Int, timeTaken: Int, difficulty: Difficulty) {
        self.date = date
        self.moves = moves
        self.timeTaken = timeTaken
        self.difficulty = difficulty
    }
}
