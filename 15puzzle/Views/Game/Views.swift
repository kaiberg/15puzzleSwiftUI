//
//  Views.swift
//  15puzzle
//
//  Created by kai delay on 02/08/2023.
//

import Foundation
import SwiftUI

struct Game: View {
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

struct GameRow: View {
    var pieces: [Int]
    
    var body: some View {
        HStack {
            ForEach(pieces, id: \.self) { piece in
                GamePiece(number: piece)
            }
            
        }
    }
}

struct GamePiece: View {
    var number: Int
    
    var body: some View {
        if number == 16 { EmptyPiece()}
        else {NumberPiece(number: number)}
    }
    
}

struct NumberPiece: View {
    var number: Int
    
    var body: some View {
        ZStack {
            Color.white
                .frame(width: 80, height: 80)
                .border(Color.black, width: 2)
            
            Text(String(number))
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct EmptyPiece: View {
    var body: some View {
        ZStack {
            Color.white
                .frame(width: 80, height: 80)
                .border(Color.white, width: 2)
            
            Text("")
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

