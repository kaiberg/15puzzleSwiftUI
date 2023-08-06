//
//  OptionState.swift
//  15puzzle
//
//  Created by kai delay on 05/08/2023.
//

import Foundation
import SwiftUI
import SwiftData

struct OptionState {
    var correct: Color
    var empty: Color
    var wrong: Color
    
    init(correct: Color, empty: Color, wrong: Color) {
        self.correct = correct
        self.empty = empty
        self.wrong = wrong
    }
}
