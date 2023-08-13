//
//  ContentView.swift
//  15puzzle
//
//  Created by kai delay on 01/08/2023.
//

import SwiftUI

struct ContentView: View {
    var state = PuzzleState()
    
    var body: some View {
        TabView {
            Game(state: state)
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }
            History(options: state.options)
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
            Options(state: state)
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
