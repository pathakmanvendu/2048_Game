//
//  GameModel.swift
//  TwoZeroFourEight Watch App
//
//  Created by manvendu pathak  on 24/10/24.
//

import SwiftUI

class GameModel: ObservableObject {
    @Published var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        grid = Array(repeating: Array(repeating: 0, count: 3), count: 3)
        addNewTile()
        addNewTile()
    }
    
    func addNewTile() {
        var emptySpaces: [(Int, Int)] = []
        for row in 0..<3 {
            for col in 0..<3 {
                if grid[row][col] == 0 {
                    emptySpaces.append((row, col))
                }
            }
        }
        
        if let randomSpace = emptySpaces.randomElement() {
            grid[randomSpace.0][randomSpace.1] = [2, 4].randomElement()!
        }
    }
    
    func slideLeft() {
        for row in 0..<3 {
            grid[row] = combineRow(rowArray: grid[row])
        }
        addNewTile()
    }
    
    func slideRight() {
        for row in 0..<3 {
            grid[row] = combineRow(rowArray: grid[row].reversed()).reversed()
        }
        addNewTile()
    }
    
    func slideUp() {
        grid = transposeGrid(grid)
        slideLeft()
        grid = transposeGrid(grid)
    }
    
    func slideDown() {
        grid = transposeGrid(grid)
        slideRight()
        grid = transposeGrid(grid)
    }
    
    private func combineRow(rowArray: [Int]) -> [Int] {
        let newRow = rowArray.filter { $0 != 0 } // Filter out zeroes
        var combinedRow: [Int] = []
        var skipNext = false
        
        for i in 0..<newRow.count {
            if skipNext {
                skipNext = false
                continue
            }
            // Combine tiles if next one is the same
            if i < newRow.count - 1 && newRow[i] == newRow[i + 1] {
                combinedRow.append(newRow[i] * 2)
                skipNext = true // Skip the next index as it has already been combined
            } else {
                combinedRow.append(newRow[i])
            }
        }
        
        // Fill the rest with zeros to maintain the row size
        return combinedRow + Array(repeating: 0, count: 3 - combinedRow.count)
    }
    
    private func transposeGrid(_ grid: [[Int]]) -> [[Int]] {
        var newGrid = Array(repeating: Array(repeating: 0, count: 3), count: 3)
        for row in 0..<3 {
            for col in 0..<3 {
                newGrid[col][row] = grid[row][col]
            }
        }
        return newGrid
    }
}

