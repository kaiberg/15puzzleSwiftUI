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
    var body: some View {
        TabView {
            Game()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }
            Options()
                .tabItem {
                    Label("Options", systemImage: "gearshape.fill")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
