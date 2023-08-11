//
//  Options.swift
//  15puzzle
//
//  Created by kai delay on 05/08/2023.
//

import SwiftUI

struct Options: View {
    @StateObject var state: PuzzleState
    
    var body: some View {
        Form {
            Section(header: Text("Settings")) {
                Picker("Difficulty", selection: $state.game.difficulty) {
                    Text("Easy").tag(Difficulty.easy)
                    Text("Medium").tag(Difficulty.medium)
                    Text("Hard").tag(Difficulty.hard)
                }
                
                ColorPicker("Empty", selection: $state.options.empty)
                ColorPicker("Correct", selection: $state.options.correct)
                ColorPicker("Incorrect", selection: $state.options.wrong)
                
                Toggle(isOn: $state.options.saveGameStatistics) {
                    Text("Save History")
                }
            }
            Section(header: Text("Previews")) {
                HStack{
                    PreviewPiece(text: "Empty", color: state.options.empty, number: 7, type: .empty)
                    PreviewPiece(text: "Correct", color: state.options.correct, number: 7, type: .correct)
                    PreviewPiece(text: "Wrong", color: state.options.wrong, number: 7, type: .wrong)
                }
            }
            
        }
    }
}

struct PreviewPiece: View {
    var text: String
    var color: Color
    var number: Int
    var type: PieceType
    var body: some View {
        VStack {
            Text(text)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 0)
            GamePiece(number: number, type: type, color: color)
        }
    }
}

#Preview {
    Options(state: PuzzleState())
}
