//
//  Piece.swift
//  15puzzle
//
//  Created by kai delay on 13/08/2023.
//

import SwiftUI

struct GamePiece: View {
    var number: Int
    var type: PieceType
    var color: Color
    
    var body: some View {
        if type == .empty { EmptyPiece(color: color)}
        else {NumberPiece(number: number, color: color)}
    }
    
}

struct NumberPiece: View {
    var number: Int
    var color = Color.red
    
    var body: some View {
        ZStack {
            Piece(color: color)
            Text(String(number))
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct EmptyPiece: View {
    var color = Color.white
    
    var body: some View {
        ZStack {
            Piece(color: color)
        }
    }}

struct Piece: View {
    var color = Color.white
    var body: some View {
        color
            .frame(width: 80, height: 80)
            .cornerRadius(20)
    }
}

#Preview {
    HStack {
        GamePiece(number: 15, type: .correct, color: .green)
        GamePiece(number: 15, type: .correct, color: .red)
        GamePiece(number: 15, type: .empty, color: .gray)
    }

}
