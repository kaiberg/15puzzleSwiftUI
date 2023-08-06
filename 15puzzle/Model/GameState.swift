//
//  State.swift
//  15puzzle
//
//  Created by kai delay on 01/08/2023.

enum Direction {
    case UP
    case DOWN
    case LEFT
    case RIGHT
}

enum Difficulty {
    case hard
    case medium
    case easy
}

enum PieceType {
    case correct
    case wrong
    case empty
}

struct piece : Hashable {
    var number: Int = 0
    var type: PieceType =  .wrong
}

struct GameState {
    var board: [[piece]] = []
    private var wrongCount: Int = 0
    private var emptyLocation: [Int] = []
    var hasWon: Bool = false
    var difficulty: Difficulty = .medium
    
    init() {
        self.Initialize()
    }
    
    private mutating func scrambleBoard() {
        let amount = difficultyToScrambleAmount(difficulty: difficulty)
        for _ in 0..<amount {
            let directions: [Direction] = [.UP, .DOWN, .LEFT, .RIGHT]
            let randomIndex = Int.random(in: 0..<directions.count)
            move(direction: directions[randomIndex])
        }
        
        if(hasWon) {
            scrambleBoard()
        }
    }
    
    mutating func move(direction: Direction) {
        var adjacentXY: [Int] = []
        
        switch direction {
        case .DOWN:
            adjacentXY = [-1, 0]
        case .UP:
            adjacentXY = [1, 0]
        case .LEFT:
            adjacentXY = [0, 1]
        case .RIGHT:
            adjacentXY = [0, -1]
        }
        
        let adjacent = [
            emptyLocation[0] + adjacentXY[0],
            emptyLocation[1] + adjacentXY[1]
        ]
        
        if !isPieceValid(XY: adjacent) {
            return
        }
        
        let temp = self.board[emptyLocation[0]][emptyLocation[1]]
        self.board[emptyLocation[0]][emptyLocation[1]] = self.board[adjacent[0]][adjacent[1]]
        self.board[adjacent[0]][adjacent[1]] = temp
        
        let n = self.board[emptyLocation[0]][emptyLocation[1]]
        let a = netPieceChange(old: emptyLocation, new: adjacent, number: temp.number)
        let b = netPieceChange(old: adjacent, new: emptyLocation, number: n.number)
        let netChange =  a + b
        
        if(b == 1) {
            board[emptyLocation[0]][emptyLocation[1]].type = .correct
        } else if(b == -1) {
            board[emptyLocation[0]][emptyLocation[1]].type = .wrong
        }
        self.wrongCount += netChange
        self.emptyLocation = adjacent
        
        self.hasWon = self.wrongCount == 0
    }
    
    mutating func Initialize() {
        self.board = []
        var counter = 1

        for _ in 0..<4 {
            var row = [piece]()
            for _ in 0..<4 {
                let correct = (counter == 16) ? PieceType.empty : .correct
                row.append(piece(number: counter, type: correct))
                counter += 1
            }
            self.board.append(row)
        }
        self.wrongCount = 0
        self.emptyLocation = [3,3]
        
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if !isCorrect(position: [i, j], number: board[i][j].number) {
                    wrongCount += 1
                }
            }
        }
        
        self.hasWon = wrongCount == 0
        
        
        scrambleBoard()
    }
}

func difficultyToScrambleAmount(difficulty: Difficulty) -> Int {
    switch difficulty {
    case .easy:
        return 70;
    case .medium:
        return 150;
    case .hard:
        return 250;
    }
}

func netPieceChange(old: [Int], new: [Int], number : Int) -> Int {
    let oldIsCorrect = isCorrect(position: old, number : number);
    let newIsCorrect = isCorrect(position: new, number : number);
    
    if(!oldIsCorrect && newIsCorrect) {
        return 1;
    }
    
    if(oldIsCorrect && !newIsCorrect) {
        return -1;
    }
    
    return 0;
}

func isPieceValid(XY: [Int]) -> Bool {
    return isValid(position: XY[0], min: 0, max: 3) && isValid(position: XY[1], min: 0, max: 3)
}

func isCorrect(position: [Int], number: Int) -> Bool {
    let row = position[0]
    let column = position[1]
    
    return row * 4 + column + 1 == number
}

func isValid(position: Int, min: Int, max: Int) -> Bool {
    return min <= position && position <= max
}


func InitialState() -> GameState {
    return GameState()
}
