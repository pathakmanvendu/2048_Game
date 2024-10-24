//
//  ContentView.swift
//  TwoZeroFourEight Watch App
//
//  Created by manvendu pathak  on 24/10/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = GameModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { col in
                            TileView(number: self.game.grid[row][col])
                        }
                    }
                }
            }
            .gesture(DragGesture()
                        .onEnded { value in
                            self.handleSwipe(value: value)
                        })
            
            Button("Restart Game") {
                game.resetGame()
            }
            .padding()
        }
        .padding()
    }
    
    func handleSwipe(value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            if horizontalAmount > 0 {
                game.slideRight()
            } else {
                game.slideLeft()
            }
        }
        else {
            if verticalAmount > 0 {
                game.slideDown()
            } else {
                game.slideUp()
            }
        }
    }
}

struct TileView: View {
    var number: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(number == 0 ? Color.gray : Color.orange)
                .cornerRadius(8)
            
            Text(number > 0 ? "\(number)" : "")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
