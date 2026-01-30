import SwiftUI

struct SudokuGrid: View {
    @StateObject var logic: SudokuLogic // ← 외부에서 받아옴
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<9) { row in
                HStack(spacing: 5) {
                    ForEach(0..<9) { col in
                        TextField("", value: Binding<Int>(
                            get: { logic.grid[row][col] },
                            set: { newValue in
                                if newValue > 0 && newValue <= 9 {
                                    if logic.isValid(row: row, col: col, value: newValue) {
                                        logic.grid[row][col] = newValue
                                    } else {
                                        logic.grid[row][col] = 0 // 중복 시 원래 값 유지
                                    }
                                }
                            }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    }
                }
            }
        }
    }
}
