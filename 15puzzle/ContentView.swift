//
//  ContentView.swift
//  15puzzle
//
//  Created by kai delay on 01/08/2023.
//

import SwiftUI

class PuzzleState: ObservableObject {
    @Published var state = State()
    @Published var lastGestureTime: Date = Date()
    
    func move(direction: Direction) {
        state.move(direction: direction)
    }
    
    func reset() {
        state.Initialize()
    }
}

struct ContentView: View {
    @StateObject private var puzzleState = PuzzleState()
    
    var body: some View {
        VStack {
            ForEach(puzzleState.state.board, id: \.self) { row in
                GameRow(pieces: row)
            }
        }
        .alert("You Won!", isPresented: $puzzleState.state.hasWon) {
            Button("restart", role: .cancel) {
                puzzleState.reset()
            }
        }
        .gesture(DragGesture()
            .onChanged { value in
                if Date().timeIntervalSince(puzzleState.lastGestureTime) >= 0.5 {
                    let gestureTranslation = value.translation
                    let direction = getDirection(from: gestureTranslation)
                    puzzleState.move(direction: direction)
                    puzzleState.lastGestureTime = Date()
                }
            }
        )
    }
    
    
    private func getDirection(from translation: CGSize) -> Direction {
        let verticalThreshold = abs(translation.height)
        let horizontalThreshold = abs(translation.width)
        
        if verticalThreshold > horizontalThreshold {
            return translation.height > 0 ? Direction.DOWN : Direction.UP
        } else {
            return translation.width > 0 ? Direction.RIGHT : Direction.LEFT
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

