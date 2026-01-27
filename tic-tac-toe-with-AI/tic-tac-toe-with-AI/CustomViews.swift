//
//  CustomViews.swift
//  tic-tac-toe-with-AI
//
//  Created by Milla Kotilainen on 27.1.2026.
//

import SwiftUI

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        // #fa8100
        // RGB: fa = 250, 81 = 129, 00 = 0
        // Swift uses values from 0.0 to 1.0
        Rectangle()
            .foregroundColor(Color(red: 250/255, green: 129/255, blue: 0/255)).opacity(0.7)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicatorView: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color.white)
    }
}
