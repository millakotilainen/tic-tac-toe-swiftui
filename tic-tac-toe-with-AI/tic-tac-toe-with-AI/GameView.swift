//
//  GameView.swift
//  tic-tac-toe-with-AI
//
//  Created by Milla Kotilainen on 26.1.2026.
//

import SwiftUI

struct GameView: View {

    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        // GeometryReader measures the available space offered by its parent, it always expands to take all available space
        GeometryReader { geometry in
            // VStack vertically stacks child views from top to bottom
            VStack {
                Picker("Difficulty", selection: $viewModel.difficulty) {
                    ForEach(Difficulty.allCases){ d in
                        Text(d.rawValue).tag(d)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.difficulty) {
                    viewModel.resetGame()
                }
                
                // Flexible empty view that expands to take available space, pushes other content away
                Spacer()
                // LazyVGrid (columns: columns) passes the colunms array, created above, into the grid.
                LazyVGrid(columns: viewModel.columns, spacing: 5){
                    // Half-open range of integers 0..<9 -> mathematically [0, 9) -> goes up to 9 but doesn't include 9
                    ForEach(0..<9) { i in
                        // ZStack is used as we want to put something on top of the squares > X or O
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicatorView(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: {alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.ButtonTitle, action: {viewModel.resetGame()}))
            })
        }
    }
}

#Preview {
    GameView()
}



