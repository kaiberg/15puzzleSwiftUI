//
//  Views.swift
//  15puzzle
//
//  Created by kai delay on 02/08/2023.
//

import Foundation
import SwiftUI

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

