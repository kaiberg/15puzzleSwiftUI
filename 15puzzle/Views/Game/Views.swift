//
//  Views.swift
//  15puzzle
//
//  Created by kai delay on 02/08/2023.
//

import Foundation
import SwiftUI

struct Game: View {
    @StateObject var state: PuzzleState
    
    var body: some View {
        VStack {
            topControls
            
            VStack {
                ForEach(state.game.board, id: \.self) { row in
                    GameRow(pieces: row, options: state.options)
                }
            }
            
            bottomControls
        }
        .frame(width: 370, height: 500)
        .alert("You Won!", isPresented: $state.game.hasWon, actions: {
            Button(
                "Play again",
                action: { state.reset() }
            )
        }, message: {
            Text("it took you \(state.game.moves) moves")
        })
        .gesture(DragGesture()
            .onChanged { value in
                if Date().timeIntervalSince(state.lastGestureTime) >= 0.5 {
                    let gestureTranslation = value.translation
                    let direction = getDirection(from: gestureTranslation)
                    state.move(direction: direction)
                    state.lastGestureTime = Date()
                }
            }
        )
    }
    
    var topControls: some View {
        HStack {
            Button {
                state.reset()
            } label: {
                Text("New Game")
            }
            .tint(state.options.empty)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 2))
            Spacer()
            
            ZStack(alignment: .trailing) {
                state.options.empty
                HStack {
                    VStack(alignment: .trailing) {
                        Text("MOVES")
                        Text("\(state.game.moves)")
                    }
                    .padding(EdgeInsets(top:16, leading: 32, bottom: 8, trailing: 0))
                    
                    
                    VStack(alignment: .trailing) {
                        Text("TIME")
                        Text("\(state.time)s")
                    }
                    .padding(EdgeInsets(top:16, leading: 32, bottom: 8, trailing: 8))
                    
                }
            }
            .cornerRadius(20)
            .fixedSize(horizontal: true, vertical: true)
        }
        
    }
    var bottomControls: some View {
        Button {
            state.pause()
        } label: {
            Text("PAUSE")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .tint(state.options.empty)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray, lineWidth: 2))
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
    var pieces: [piece]
    var options: OptionState
    
    var body: some View {
        HStack {
            ForEach(pieces, id: \.self.number) { piece in
                let color = (piece.type == .empty) ? options.empty
                : (piece.type == .correct)
                ? options.correct
                : options.wrong
                GamePiece(number: piece.number, type: piece.type, color: color)
            }
            
        }
    }
}

struct GamePiece: View {
    var number: Int
    var type: PieceType
    var color: Color
    
    var body: some View {
        if type == .empty { EmptyPiece(color: color)}
        else {NumberPiece(number: number, color: color)}
    }
    
}

#Preview {
    //    NumberPiece(number: 2)
    Game(state: PuzzleState())
}

struct NumberPiece: View {
    var number: Int
    var color = Color.red
    
    var body: some View {
        ZStack {
            color
                .frame(width: 80, height: 80)
                .cornerRadius(20)
            
            Text(String(number))
                .font(.extraLargeTitle)
                .foregroundColor(.white)
        }
    }
}

struct EmptyPiece: View {
    var color = Color.white
    
    var body: some View {
        ZStack {
            color
                .frame(width: 80, height: 80)
                .cornerRadius(20)
            
        }
        
    }}
