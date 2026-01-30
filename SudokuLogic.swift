import Foundation

class SudokuLogic: ObservableObject {
    @Published var board = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    
    init() {
        generatePuzzle()
    }
    
    func generatePuzzle() {
        board = [
            [5, 3, 0, 0, 7, 0, 0, 0, 0],
            [6, 0, 0, 1, 9, 5, 0, 0, 0],
            [0, 9, 8, 0, 0, 0, 0, 6, 0],
            [8, 0, 0, 0, 6, 0, 0, 0, 3],
            [4, 0, 0, 8, 0, 3, 0, 0, 1],
            [7, 0, 0, 0, 2, 0, 0, 0, 6],
            [0, 6, 0, 0, 0, 0, 2, 8, 0],
            [0, 0, 0, 4, 1, 9, 0, 0, 5],
            [0, 0, 0, 0, 8, 0, 0, 7, 9]
        ]
    }
    
    func isValid(row: Int, col: Int, value: Int) -> Bool { // ← num → value로 변경
        for j in 0..<9 {
            if board[row][j] == value { return false }
        }
        
        for i in 0..<9 {
            if board[i][col] == value { return false }
        }
        
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        
        for i in startRow..<startRow + 3 {
            for j in startCol..<startCol + 3 {
                if board[i][j] == value { return false }
            }
        }
        
        return true
    }
    
    func isSolved() -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == 0 || !isValid(row: i, col: j, value: board[i][j]) {
                    return false
                }
            }
        }
        return true
    }
    
    func reset() {
        generatePuzzle()
    }
}
