import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("스도쿠 대결 게임")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("연습 모드 (혼자)") {
                print("연습 모드 시작!")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("대결 모드 (2인)") {
                print("대결 모드 시작!")
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
