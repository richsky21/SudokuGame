import SwiftUI

struct SudokuGameView: View {
    @StateObject var logic = SudokuLogic()
    @State private var isPlayer1Turn = true
    @State private var player1Time = 0
    @State private var player2Time = 0
    @State private var gameStatusMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("스도쿠 게임")
                .font(.title)
                .fontWeight(.bold)
            
            VStack {
                if isPlayer1Turn {
                    Text("플레이어 1 차례 (시간: \(player1Time)s)")
                        .foregroundColor(.blue)
                } else {
                    Text("플레이어 2 차례 (시간: \(player2Time)s)")
                        .foregroundColor(.red)
                }
            }
            .font(.headline)
            
            GridBoardView(logic: logic, isPlayer1Turn: $isPlayer1Turn)
            
            Text(gameStatusMessage)
                .foregroundColor(.orange)
            
            HStack(spacing: 20) {
                Button("새 게임") {
                    logic.reset()
                    isPlayer1Turn = true
                    player1Time = 0
                    player2Time = 0
                    gameStatusMessage = ""
                }
                .buttonStyle(.bordered)
                
                Button("승패 결정") {
                    if logic.isSolved() {
                        let winner = isPlayer1Turn ? "플레이어 1" : "플레이어 2"
                        gameStatusMessage = "\(winner) 승리!"
                    } else {
                        gameStatusMessage = "아직 완성되지 않았거나 틀린 곳이 있습니다."
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct GridBoardView: View {
    @ObservedObject var logic: SudokuLogic
    @Binding var isPlayer1Turn: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(0..<9, id: \.self) { col in
                        let value = logic.board[row][col]
                        
                        TextField("", value: Binding<Int>(
                            get: { value == 0 ? 0 : value },
                            set: { newValue in
                                // 빈 칸일 때만 입력 가능하게 하거나, 자유롭게 수정 가능하게 로직 조정 가능
                                if logic.isValid(row: row, col: col, num: newValue) {
                                    logic.board[row][col] = newValue
                                    isPlayer1Turn.toggle()
                                }
                            }
                        ), format: .number)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 35, height: 35)
                        .background(value == 0 ? Color.clear : Color.gray.opacity(0.1))
                    }
                }
            }
        }
    }
}
