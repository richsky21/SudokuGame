import Foundation

class SudokuLogic: ObservableObject {
    @Published var board = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    
    init() {
        generatePuzzle()
    }
    
    func generatePuzzle() {
        // 샘플 데이터 (0은 빈칸)
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
    
    func reset() {
        generatePuzzle()
    }
    
    func isValid(row: Int, col: Int, num: Int) -> Bool {
        if num < 1 || num > 9 { return false }
        
        for j in 0..<9 {
            if j != col && board[row][j] == num { return false }
        }
        
        for i in 0..<9 {
            if i != row && board[i][col] == num { return false }
        }
        
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for i in startRow..<startRow + 3 {
            for j in startCol..<startCol + 3 {
                if (i != row || j != col) && board[i][j] == num { return false }
            }
        }
        return true
    }
    
    func isSolved() -> Bool {
        for r in 0..<9 {
            for c in 0..<9 {
                if board[r][c] == 0 || !isValid(row: r, col: c, num: board[r][c]) {
                    return false
                }
            }
        }
        return true
    }
}
