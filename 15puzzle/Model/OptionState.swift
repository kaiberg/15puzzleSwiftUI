//
//  OptionState.swift
//  15puzzle
//
//  Created by kai delay on 05/08/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class OptionState {
    var correct: Color
    var empty: Color
    var wrong: Color
    var saveGameStatistics: Bool
    
    init(correct: Color, empty: Color, wrong: Color, saveGameStatistics: Bool) {
        self.correct = correct
        self.empty = empty
        self.wrong = wrong
        self.saveGameStatistics = saveGameStatistics
    }
}
