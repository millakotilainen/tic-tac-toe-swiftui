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

enum Difficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String {
        return rawValue
    }
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
