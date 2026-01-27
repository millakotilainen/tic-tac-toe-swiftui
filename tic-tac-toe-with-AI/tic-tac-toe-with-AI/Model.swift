//
//  Model.swift
//  tic-tac-toe-with-AI
//
//  Created by Milla Kotilainen on 27.1.2026.
//

import SwiftUI


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
