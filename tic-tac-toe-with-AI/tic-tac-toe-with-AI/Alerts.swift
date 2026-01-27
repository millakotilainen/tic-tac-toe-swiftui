//
//  Alerts.swift
//  tic-tac-toe-with-AI
//
//  Created by Milla Kotilainen on 27.1.2026.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var ButtonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You won!"),
                                    message: Text("Congratulations! You beat the AI!"),
                                    ButtonTitle: Text("Play again"))
    
    static let computerWin = AlertItem(title: Text("Computer won!"),
                                       message: Text("Sorry, but the AI beat you this time."),
                                       ButtonTitle: Text("Play again"))
    
    static let draw = AlertItem(title: Text("It's a draw!"),
                                message: Text("You and the AI tied this time."),
                                ButtonTitle: Text("Play again"))
}
