import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("스도쿠 대결 게임")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink(destination: SudokuGameView()) {
                    Text("연습 모드 (혼자)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SudokuGameView()) {
                    Text("대결 모드 (2인)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(40)
        }
    }
}
