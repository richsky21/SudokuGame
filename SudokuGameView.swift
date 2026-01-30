import SwiftUI

struct SudokuGameView: View {
    @StateObject private var logic = SudokuLogic() // ← private + StateObject
    @State private var isPlayer1Turn = true
    @State private var player1Time = 0, player2Time = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("스도쿠 게임")
                .font(.title)
                .fontWeight(.bold)
            
            if isPlayer1Turn {
                Text("플레이어 1 차례 (시간: $player1Time)s)")
                    .foregroundColor(.blue)
            } else {
                Text("플레이어 2 차례 (시간: $player2Time)s)")
                    .foregroundColor(.red)
            }
            
            GridBoardView(logic: logic, isPlayer1Turn: $isPlayer1Turn, player1Time: $player1Time, player2Time: $player2Time)
            
            HStack {
                Button("새 게임") {
                    logic.reset()
                    isPlayer1Turn = true
                    player1Time = 0
                    player2Time = 0
                }
                
                Button("승패 결정") {
                    if logic.isSolved() {
                        let winner = isPlayer1Turn ? "플레이어 1" : "플레이어 2"
                        print("$winner) 승리!")
                    } else {
                        print("아직 완성되지 않았습니다.")
                    }
                }
            }
        }
        .padding()
    }
}

struct GridBoardView: View {
    @StateObject var logic: SudokuLogic // ← StateObject로 변경
    @Binding var isPlayer1Turn: Bool
    @Binding var player1Time: Int
    @Binding var player2Time: Int
    
    let grid = Array(0..<9)
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(grid, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(grid, id: \.self) { col in
                        let value = logic.board[row][col]
                        
                        TextField("", value: Binding<Int>(
                            get: { value },
                            set: { newValue in
                                if isPlayer1Turn && value == 0 {
                                    if logic.isValid(row: row, col: col, value: newValue) {
                                        logic.board[row][col] = newValue // 값 저장
                                        isPlayer1Turn.toggle() // 차례 전환
                                    }
                                }
                            }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 40, height: 40)
                        .background(value == 0 ? Color.clear : Color.gray.opacity(0.2))
                    }
                }
            }
        }
    }
}
