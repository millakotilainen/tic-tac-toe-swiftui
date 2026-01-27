//
//  ContentView.swift
//  tic-tac-toe-with-AI
//
//  Created by Milla Kotilainen on 26.1.2026.
//

import SwiftUI


// When SwiftUI need to render ContentView, it evaluates "var body: some View"
struct ContentView: View {
    // constant layout config only used in ContentView > private
    // GridItem(.flexible()), >  Column can expand to fill available width, all colums share space evenly
    // let -> immutable
    // private -> only visible inside this file
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisabled: Bool = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        // GeometryReader measures the available space offered by its parent, it always expands to take all available space
        GeometryReader { geometry in
            // VStack vertically stacks child views from top to bottom
            VStack {
                // Flexible empty view that expands to take available space, pushes other content away
                Spacer()
                // LazyVGrid (columns: columns) passes the colunms array, created above, into the grid.
                LazyVGrid(columns: columns, spacing: 5){
                    // Half-open range of integers 0..<9 -> mathematically [0, 9) -> goes up to 9 but doesn't include 9
                    ForEach(0..<9) { i in
                        // ZStack is used as we want to put something on top of the squares > X or O
                        ZStack {
                            // #fa8100
                            // RGB: fa = 250, 81 = 129, 00 = 0
                            // Swift uses values from 0.0 to 1.0
                            Rectangle()
                                .foregroundColor(Color(red: 250/255, green: 129/255, blue: 0/255)).opacity(0.7)
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: .human, boardIndex: i)
                                                        
                            //check for win condition or draw
                            if checkWinCondition(for: .human, in: moves) {
                                alertItem = AlertContext.humanWin
                                return
                            }
                            
                            if checkForDrawCondition(in: moves) {
                                alertItem = AlertContext.draw
                                return
                            }
                            
                            isGameBoardDisabled = true

                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = determineComputerMovePosition(in: moves)
                                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                isGameBoardDisabled = false
                                
                                if checkWinCondition(for: .computer, in: moves) {
                                    alertItem = AlertContext.computerWin
                                    return
                                }
                                
                                if checkForDrawCondition(in: moves) {
                                    alertItem = AlertContext.draw
                                    return
                                }
                            }
                        }
                    }
                    
                }
                Spacer()
            }
            .disabled(isGameBoardDisabled)
            .padding()
            .alert(item: $alertItem, content: {alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.ButtonTitle, action: {resetGame()}))
            })
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool  {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?] )-> Int{
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
             movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        // Series of board indexes that will make a win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap{$0}.filter{$0.player == player}
        let playerPostition = Set(playerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPostition) { return true }
        
        return false
    }
    
    func checkForDrawCondition(in moves: [Move?]) -> Bool{
        return moves.compactMap({$0}).count == 9
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
    }
}


enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}


#Preview {
    ContentView()
}
