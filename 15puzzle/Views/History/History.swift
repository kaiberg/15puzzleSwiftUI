//
//  History.swift
//  15puzzle
//
//  Created by kai delay on 11/08/2023.
//

import SwiftUI
import SwiftData

enum DifficultyFilter {
    case none
    case easy
    case medium
    case hard
}

enum DateFilter {
    case none
    case week
    case month
    case quarter
    case year
}

struct History: View {
    @State private var difficultyFilter: DifficultyFilter = .none
    @State private var dateFilter: DateFilter = .none
    @Bindable var options: OptionState
    
    // dynamic queries are not possible yet
    @Query private var games: [GameRecord]
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading){
                    Text("Difficulty").padding(.leading)
                    Picker("Difficulty", selection: $difficultyFilter) {
                        Text("none").tag(DifficultyFilter.none)
                        Text("easy").tag(DifficultyFilter.easy)
                        Text("medium").tag(DifficultyFilter.medium)
                        Text("hard").tag(DifficultyFilter.hard)
                    }
                }
                
                VStack(alignment:.leading){
                    Text("Date").padding(.leading)
                    Picker("Date", selection: $dateFilter) {
                        Text("none").tag(DifficultyFilter.none)
                        Text("last 7 days").tag(DateFilter.week)
                        Text("last month").tag(DateFilter.month)
                        Text("last quarter").tag(DateFilter.quarter)
                        Text("last year").tag(DateFilter.year)
                    }
                }

                Spacer()
            }.padding(.all)

            
            List(games) { game in
                GameRecordRow(record: game)
                    .listRowBackground(options.empty)
            }.scrollContentBackground(.hidden)
        }
        .padding(.all)
    }
}

struct GameRecordRow: View {
    var record: GameRecord
    var body: some View {
        HStack {
            Image(systemName: getIcon(difficulty: record.difficulty))
            VStack {
                HStack {
                    Text("Moves: \(record.moves)").font(.headline)
                    Spacer()
                    Text(record.date, style: .date).foregroundColor(.secondary)
                }
                HStack {
                    Text("Time taken: \(record.timeTaken)")
                    Spacer()
                }
            }
        }
    }
    
    private func getIcon(difficulty : Difficulty) -> String {
        switch difficulty {
        case Difficulty.easy:
            return "face.smiling"
        case Difficulty.medium:
            return "sparkles"
        case Difficulty.hard:
            return "flame.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
}

#Preview {
    History(options: PuzzleState().options)
}
